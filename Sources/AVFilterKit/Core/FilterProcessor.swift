//
//  File.swift
//  AVFilterKit
//
//  Created by 조호근 on 2/27/25.
//

import CoreImage.CIFilterBuiltins

public class FilterProcessor {
    
    @MainActor
    private static let context = CIContext()
    
    private init() {}
    
    public static func apply(_ filter: Filter, to ciImage: CIImage) async -> CIImage? {
        
        var result = ciImage
        
        let colorControls = CIFilter.colorControls()
        colorControls.inputImage = result
        colorControls.contrast = normalizeContrast(filter.adjustments.contrast)
        colorControls.saturation = normalizeSaturation(filter.adjustments.saturation)
        
        if let adjusted = colorControls.outputImage {
            result = adjusted
        }
        
        let temperatureAndTint = CIFilter.temperatureAndTint()
        colorControls.inputImage = result
        let normalizedTemp = normalizeTemperature(filter.adjustments.temperature)
        temperatureAndTint.targetNeutral = CIVector(x: normalizedTemp)
        
        if let adjusted = temperatureAndTint.outputImage {
            result = adjusted
        }
        
        let vignette = CIFilter.vignette()
        vignette.inputImage = result
        vignette.intensity = normalizeVignette(filter.adjustments.vignette)
        
        if let adjusted = vignette.outputImage {
            result = adjusted
        }
        
        if filter.adjustments.grain > 0 {
            let noiseGenerator = CIFilter.randomGenerator()
            let noise = noiseGenerator.outputImage?.cropped(to: result.extent)
            
            let noiseControls = CIFilter.colorControls()
            noiseControls.inputImage = noise
            noiseControls.contrast = normalizeGrain(filter.adjustments.grain)
            noiseControls.saturation = 0
            
            if let processedNoise = noiseControls.outputImage {
                let blend = CIFilter.multiplyCompositing()
                blend.inputImage = processedNoise
                blend.backgroundImage = result
                
                if let adjusted = blend.outputImage {
                    result = adjusted
                }
            }
        }
        
        return result
    }
    
    @MainActor public static func convertToCGImage(from ciImage: CIImage) -> CGImage? {
        return FilterProcessor.context.createCGImage(ciImage, from: ciImage.extent)
    }
    
}

extension FilterProcessor {
    
    // MARK: - Value Normalizers
       private static func normalizeContrast(_ value: Float) -> Float {
           let normalized = (value + 100) / 200
           return Float(normalized * 3.75 + 0.25)
       }
       
       private static func normalizeSaturation(_ value: Float) -> Float {
           let normalized = (value + 100) / 200
           return Float(normalized * 2.0)
       }
       
       private static func normalizeTemperature(_ value: Float) -> CGFloat {
           let normalized = (value + 50) / 100
           return CGFloat(normalized * 5000 + 4000)
       }
       
       private static func normalizeVignette(_ value: Float) -> Float {
           let normalized = value / 100
           return Float(normalized * 2.0 - 1.0)
       }
       
       private static func normalizeGrain(_ value: Float) -> Float {
           return Float(value / 100)
       }
}

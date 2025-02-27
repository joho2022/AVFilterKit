//
//  File.swift
//  AVFilterKit
//
//  Created by 조호근 on 2/27/25.
//

import CoreImage

public class FilterProcessor {
    
    private let context = CIContext()
    
    public init() {}
    
    public func apply(_ filter: Filter, to ciImage: CIImage) async -> CIImage? {
        
        var result = ciImage
        
        if let adjusted = applyAdjustment(
            filter.adjustments.contrast,
            to: result,
            filterName: "CIColorControls",
            parameter: kCIInputContrastKey
        ) {
            result = adjusted
        }
        
        if let adjusted = applyAdjustment(
            filter.adjustments.saturation,
            to: result,
            filterName: "CIColorControls",
            parameter: kCIInputSaturationKey
        ) {
            result = adjusted
        }
        
        if let adjusted = applyAdjustment(
            filter.adjustments.temperature,
            to: result,
            filterName: "CITemperatureAndTint",
            parameter: "inputNeutral"
        ) {
            result = adjusted
        }
        
        if let adjusted = applyAdjustment(
            filter.adjustments.vignette,
            to: result,
            filterName: "CIVignette",
            parameter: kCIInputIntensityKey
        ) {
            result = adjusted
        }
        
        if let adjusted = applyGrain(
            filter.adjustments.grain,
            to: result
        ) {
            result = adjusted
        }
        
        return result
    }
    
    public func convertToCGImage(from ciImage: CIImage) -> CGImage? {
        return context.createCGImage(ciImage, from: ciImage.extent)
    }
    
}

extension FilterProcessor {
    
    private func applyAdjustment(
        _ adjustment: Adjustment,
        to image: CIImage,
        filterName: String,
        parameter: String
    ) -> CIImage? {
        guard adjustment.range.contains(adjustment.value) else {
            print("⚠️ \(filterName) - \(parameter) value is out of range: \(adjustment.value)")
            return nil
        }
        
        guard let filter = CIFilter(name: filterName) else { return nil }
        filter.setValue(image, forKey: kCIInputImageKey)
        filter.setValue(adjustment.value / 100, forKey: parameter)
        
        return filter.outputImage
    }
    
    private func applyGrain(
        _ adjustment: Adjustment,
        to image: CIImage
    ) -> CIImage? {
        guard adjustment.range.contains(adjustment.value) else {
            print("⚠️ Grain value is out of range: \(adjustment.value)")
            return nil
        }
        
        guard let noiseFilter = CIFilter(name: "CIRandomGenerator"),
              let blendFilter = CIFilter(name: "CIMultiplyCompositing") else { return nil }
        
        let noiseImage = noiseFilter.outputImage?
            .cropped(to: image.extent)
            .applyingFilter("CIColorControls", parameters: [
                kCIInputContrastKey: adjustment.value / 50.0,
                kCIInputSaturationKey: 0
            ])
        
        blendFilter.setValue(noiseImage, forKey: kCIInputImageKey)
        blendFilter.setValue(image, forKey: kCIInputBackgroundImageKey)
        
        return blendFilter.outputImage
    }
    
}

import Testing
import CoreImage
@testable import AVFilterKit

@Suite("FilterProcessor Tests")
struct FilterProcessorTests {
    
    @Test func testContrastFilter() async throws {
        // Given
        let filter = FilterBuilder(name: "Contrast Test")
            .contrast(-20)
            .build()
        let testImage = createTestImage()
        
        // When & Then
        Task {
            let outputImage = await FilterProcessor.apply(filter, to: testImage)
            
            #expect(outputImage != nil)
            #expect(outputImage?.extent.size == testImage.extent.size)
        }
    }
    
    @Test func testMultipleFilters() async throws {
        // Given
        let filter = FilterBuilder(name: "Complex Filter")
            .contrast(-20)
            .saturation(-15)
            .temperature(5)
            .grain(40)
            .vignette(30)
            .build()
        let testImage = createTestImage()
        
        // When & Then
        Task {
            let outputImage = await FilterProcessor.apply(filter, to: testImage)
            #expect(outputImage != nil)
            
            if let output = outputImage {
                #expect(output.extent.size == testImage.extent.size)
                
                let context = CIContext()
                let cgImage = context.createCGImage(output, from: output.extent)
                #expect(cgImage != nil)
            }
        }
    }
    
    @Test func testExtremeValues() async throws {
        // Given
        let filter = FilterBuilder(name: "Extreme Values")
            .contrast(5100)
            .saturation(-1250)
            .temperature(10000)
            .grain(150)
            .vignette(-50)
            .build()
        let testImage = createTestImage()
        
        // When & Then
        Task {
            let outputImage = await FilterProcessor.apply(filter, to: testImage)
            #expect(outputImage != nil)
            
            if let output = outputImage {
                #expect(output.extent.size == testImage.extent.size)
                
                let context = CIContext()
                let cgImage = context.createCGImage(output, from: output.extent)
                #expect(cgImage != nil)
            }
        }
    }
    
    
}

extension FilterProcessorTests {
    
    private func createTestImage(size: CGSize = CGSize(width: 100, height: 100)) -> CIImage {
        let color = CIColor(red: 0.5, green: 0.5, blue: 0.5)
        return CIImage(color: color).cropped(to: CGRect(origin: .zero, size: size))
    }
    
}

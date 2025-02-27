//
//  FilterAdjustments.swift
//  AVFilterKit
//
//  Created by 조호근 on 2/27/25.
//

public struct FilterAdjustments: Equatable {
    
    public var contrast: Adjustment
    public var saturation: Adjustment
    public var temperature: Adjustment
    public var grain: Adjustment
    public var vignette: Adjustment
    
    public init(
        contrast: Double = 0,
        saturation: Double = 0,
        temperature: Double = 0,
        grain: Double = 0,
        vignette: Double = 0
    ) {
        self.contrast = Adjustment(value: contrast, range: -100...100)
        self.saturation = Adjustment(value: saturation, range: -100...100)
        self.temperature = Adjustment(value: temperature, range: -50...50)
        self.grain = Adjustment(value: grain, range: 0...100)
        self.vignette = Adjustment(value: vignette, range: 0...100)
    }
    
}

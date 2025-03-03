//
//  FilterAdjustments.swift
//  AVFilterKit
//
//  Created by 조호근 on 2/27/25.
//

public struct FilterAdjustments: Equatable {
    
    public var contrast: Float
    public var saturation: Float
    public var temperature: Float
    public var grain: Float
    public var vignette: Float
    
    public init(
        contrast: Float = 1.0,
        saturation: Float = 1.0,
        temperature: Float = 6500,
        grain: Float = 0.0,
        vignette: Float = 0.0
    ) {
        self.contrast = contrast
        self.saturation = saturation
        self.temperature = temperature
        self.grain = grain
        self.vignette = vignette
    }
    
}

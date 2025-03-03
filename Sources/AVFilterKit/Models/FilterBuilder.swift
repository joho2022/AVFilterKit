//
//  FilterBuilder.swift
//  AVFilterKit
//
//  Created by 조호근 on 2/27/25.
//

import Foundation

public class FilterBuilder {
    private let name: String
    private var adjustments = FilterAdjustments()
    
    init(name: String) {
        self.name = name
    }
    
    public func contrast(_ value: Float) -> FilterBuilder {
        adjustments.contrast = value
        return self
    }
    
    public func saturation(_ value: Float) -> FilterBuilder {
        adjustments.saturation = value
        return self
    }
    
    public func temperature(_ value: Float) -> FilterBuilder {
        adjustments.temperature = value
        return self
    }
    
    public func grain(_ value: Float) -> FilterBuilder {
        adjustments.grain = value
        return self
    }
    
    public func vignette(_ value: Float) -> FilterBuilder {
        adjustments.vignette = value
        return self
    }
    
    public func build() -> Filter {
        return Filter(name: name, adjustments: adjustments)
    }
    
}

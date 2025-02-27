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
    
    public func contrast(_ value: Double) -> FilterBuilder {
        adjustments.contrast = Adjustment(value: value, range: -100...100)
        return self
    }
    
    public func saturation(_ value: Double) -> FilterBuilder {
        adjustments.saturation = Adjustment(value: value, range: -100...100)
        return self
    }
    
    public func temperature(_ value: Double) -> FilterBuilder {
        adjustments.temperature = Adjustment(value: value, range: -50...50)
        return self
    }
    
    public func grain(_ value: Double) -> FilterBuilder {
        adjustments.grain = Adjustment(value: value, range: 0...100)
        return self
    }
    
    public func vignette(_ value: Double) -> FilterBuilder {
        adjustments.vignette = Adjustment(value: value, range: 0...100)
        return self
    }
    
    public func build() -> Filter {
        return Filter(name: name, adjustments: adjustments)
    }
    
}

//
//  Filter.swift
//  AVFilterKit
//
//  Created by 조호근 on 2/27/25.
//

import Foundation

public struct Filter: Equatable, Identifiable {
    
    public let id = UUID()
    public let name: String
    public let adjustments: FilterAdjustments
    
    public init(name: String, adjustments: FilterAdjustments) {
        self.name = name
        self.adjustments = adjustments
    }
    
    public static func builder(_ name: String) -> FilterBuilder {
        return FilterBuilder(name: name)
    }
    
}

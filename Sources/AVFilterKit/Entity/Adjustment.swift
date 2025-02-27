//
//  Adjustment.swift
//  AVFilterKit
//
//  Created by 조호근 on 2/27/25.
//

public struct Adjustment {
    
    public let value: Double
    public let range: ClosedRange<Double>
    
    public init(value: Double, range: ClosedRange<Double>) {
        self.value = value
        self.range = range
    }
    
}

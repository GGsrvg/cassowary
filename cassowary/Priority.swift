//
//  Priority.swift
//  cassowary
//
//  Created by GGsrvg on 1/15/25.
//

import Foundation

/// Range 0 - 1000
public struct Priority: Hashable {
    let value: Int
    
    init(_ value: Int) {
        var value = value
        if value < 0 {
            value = 0
        } else if value > 1000 {
            value = 1000
        }
        
        self.value = value
    }
    
    public static let nothing: Priority = .init(0)
    public static let low: Priority = .init(250)
    public static let medium: Priority = .init(500)
    public static let high: Priority = .init(750)
    public static let required: Priority = .init(1000)
}

extension Priority: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: IntegerLiteralType) {
        self.init(value)
    }
}


extension Priority: Comparable {
    public static func < (lhs: Priority, rhs: Priority) -> Bool {
        lhs.value < rhs.value
    }
}

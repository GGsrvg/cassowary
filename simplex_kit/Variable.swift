//
//  Variable.swift
//  simplex
//
//  Created by GGsrvg on 10/25/24.
//

import Foundation

public struct Variable: Hashable, Comparable {
    public static func < (lhs: Variable, rhs: Variable) -> Bool {
        lhs.tag < rhs.tag
    }
    
    let tag: String
    
    public init(tag: String) {
        self.tag = tag
    }
    
    static func createS(_ number: Int) -> Variable {
        return Variable(tag: "z\(number)")
    }
    
    static public func * (variable: Variable, multiplier: Decimal) -> Expression {
        return .plus([
            .variable(multiplier: multiplier, variable)
        ])
    }
    
    static public func * (variable: Variable, multiplier: Int) -> Expression {
        return variable * Decimal(multiplier)
    }
    
    static public func * (variable: Variable, multiplier: Float) -> Expression {
        return variable * Decimal(Double(multiplier))
    }
    
    static public func * (variable: Variable, multiplier: Double) -> Expression {
        return variable * Decimal(multiplier)
    }
    
    static public func * (multiplier: Decimal, variable: Variable) -> Expression {
        return variable * multiplier
    }
    
    static public func * (multiplier: Int, variable: Variable) -> Expression {
        return variable * Decimal(multiplier)
    }
    
    static public func * (multiplier: Float, variable: Variable) -> Expression {
        return variable * Decimal(Double(multiplier))
    }
    
    static public func * (multiplier: Double, variable: Variable) -> Expression {
        return variable * Decimal(multiplier)
    }
}

extension Variable: CustomStringConvertible, CustomDebugStringConvertible {
    public var description: String {
        tag
    }
    
    public var debugDescription: String {
        description
    }
}

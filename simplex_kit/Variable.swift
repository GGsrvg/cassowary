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
    
    static func createF() -> Variable {
        return Variable(tag: "F")
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

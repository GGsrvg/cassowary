//
//  Expression.swift
//  simplex
//
//  Created by GGsrvg on 10/25/24.
//

import Foundation

public enum Expression {
    case number(Decimal)
    case variable(multiplier: Decimal, Variable)
    indirect case plus([Expression])
    
    public func optimize() -> Expression {
        switch self {
        case .number:
            return self
        case .variable:
            return self
        case .plus(let array):
            if array.count == 0 {
                return .number(.zero)
            }
            if array.count == 1, let first = array.first {
                return first.optimize()
            }
            let summOfNumbers = self.getNumbers().reduce(.zero, +)
            let summOfVariables = Array(self.getVariablesAndMultiplier()).sorted(by: { $0.0 < $1.0 })
            var newExpressions = summOfVariables
                .map { Expression.variable(multiplier: $0.1, $0.0) }
            if summOfNumbers != .zero {
                newExpressions += [Expression.number(summOfNumbers)]
            }
            return .plus(newExpressions)
        }
    }
    
    func getEquation() -> Equation {
        let summOfVariables = Array(self.getVariablesAndMultiplier()).sorted(by: { $0.0 < $1.0 })
        let expressions = summOfVariables
            .map { Expression.variable(multiplier: $0.1, $0.0) }
        return Equation(
            left: .plus(expressions),
            relation: .equal,
            right: .number(self.getNumbers().reduce(.zero, +) * -1)
        )
    }

    func getNumbers() -> [Decimal] {
        switch self {
        case .number(let number):
            return [number]
        case .variable:
            return []
        case .plus(let array):
            return array.flatMap { $0.getNumbers() }
        }
    }

    func getNumbersAndMultiplier() -> [Decimal] {
        switch self {
        case .number(let number):
            return [number]
        case .variable(multiplier: let multiplier, _):
            return [multiplier]
        case .plus(let array):
            return array.flatMap { $0.getNumbers() }
        }
    }

    func getVariables() -> [Variable] {
        switch self {
        case .number:
            return []
        case .variable(_, let variable):
            return [variable]
        case .plus(let array):
            return array.flatMap { $0.getVariables() }
        }
    }

    func getVariablesAndMultiplier() -> [Variable: Decimal] {
        switch self {
        case .number:
            return [:]
        case .variable(multiplier: let multiplier, let variable):
            return [variable: multiplier]
        case .plus(let array):
            let result = array.reduce([Variable: Decimal]()) { (result, expression) in
                var newResult = result
                let variables = expression.getVariablesAndMultiplier()
                for variable in variables {
                    newResult[variable.0] = (newResult[variable.0] ?? .zero) + variable.1
                }
                return newResult
            }
            return result
        }
    }

    static public func + (lhs: Expression, rhs: Expression) -> Expression {
        return .plus([lhs, rhs]).optimize()
    }
    
    static public func * (l: Expression, r: Decimal) -> Expression {
        switch l {
        case let .number(decimal):
            return .number(decimal * r)
        case let .variable(multiplier: multiplier, variable):
           return .variable(multiplier: multiplier * r, variable)
        case let .plus(expressions):
            return .plus(expressions.map { $0 * r }).optimize()
        }
    }
    
    static public func * (l: Decimal, r: Expression) -> Expression {
        switch r {
        case let .number(decimal):
            return .number(decimal * l)
        case let .variable(multiplier: multiplier, variable):
           return .variable(multiplier: multiplier * l, variable)
        case let .plus(expressions):
            return .plus(expressions.map { $0 * l }).optimize()
        }
    }
    
    static public func * (l: Expression, r: Int) -> Expression {
        return l * Decimal(r)
    }
    
    static public func * (l: Expression, r: Double) -> Expression {
        return l * Decimal(r)
    }
    
    static public func * (l: Int, r: Expression) -> Expression {
        return r * Decimal(l)
    }
    
    static public func * (l: Double, r: Expression) -> Expression {
        return r * Decimal(l)
    }
}

extension Expression: CustomStringConvertible {
    public var description: String {
        switch self {
        case .number(let number):
            return number.description
        case .variable(multiplier: let multiplier, let variable):
            return "\(multiplier)\(variable.tag)"
        case .plus(let array):
            return array.map { $0.description }.joined(separator: " + ")
        }
    }
}

extension Expression: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Float) {
        self = .number(Decimal(Double(value)))
    }
}

extension Expression: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = .number(Decimal(value))
    }
}

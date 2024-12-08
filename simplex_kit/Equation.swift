//
//  Equation.swift
//  simplex
//
//  Created by GGsrvg on 10/25/24.
//

import Foundation

public struct Equation {
    let left: Expression
    let relation: Relation
    let right: Expression
    
    public init(left: Expression, relation: Relation, right: Expression) {
        self.left = left
        self.relation = relation
        self.right = right
    }
    
    public init(expression: Expression) {
        self.left = expression.optimize()
        self.relation = .equal
        self.right = expression
    }
    
    func canonical(i: Int? = nil) -> (Equation, Variable?) {
        switch relation {
        case .equal:
            let basis = self.left.getVariablesAndMultiplier().first { (key: Variable, value: Decimal) in
                value == 1
            }.map(\.key)
            guard let basis else {
                return (self, nil)
            }
            return (
                self,
                basis
            )
            
        case .lessOrEqual:
            let basis = Variable.createS(i ?? 1)
            let exp = Expression.variable(multiplier: 1, basis)
            return (
                Equation(
                    left: left + exp,
                    relation: .equal,
                    right: right
                ),
                basis
            )
        case .greaterOrEqual:
            let basis = Variable.createS(i ?? 1)
            let exp = Expression.variable(multiplier: 1, basis)
            return (
                Equation(
                    left: (left * -1) + exp,
                    relation: .equal,
                    right: right * -1
                ),
                basis
            )
        }
    }
    
    func canonicalWithBasis(i: Int? = nil) -> (Equation, Variable?) {
        let variable = Variable.createS(i ?? 1)
        
        switch relation {
        case .equal:
            return (self, nil)
        case .lessOrEqual:
            let exp = Expression.variable(multiplier: 1, variable)
            return (Equation(
                left: left + exp,
                relation: .equal,
                right: right
            ), variable)
        case .greaterOrEqual:
            let exp = Expression.variable(multiplier: -1, variable)
            return (Equation(
                left: left + exp,
                relation: .equal,
                right: right
            ), variable)
        }
    }
    
    func getVariables() -> Set<Variable> {
        let l = left.getVariables()
        let r = right.getVariables()
        return Set(l + r)
    }
    
    static func * (equation: Equation, multiplier: Decimal) -> Equation {
        switch equation.relation {
        case .equal:
            return Equation(
                left: equation.left * multiplier,
                relation: .equal,
                right: equation.right * multiplier
            )
        case .lessOrEqual:
            return Equation(
                left: equation.left * multiplier,
                relation: .greaterOrEqual,
                right: equation.right * multiplier
            )
        case .greaterOrEqual:
            return Equation(
                left: equation.left * multiplier,
                relation: .lessOrEqual,
                right: equation.right * multiplier
            )
        }
    }
}

extension Equation: CustomStringConvertible {
    public var description: String {
        return "\(left) \(relation) \(right)"
    }
}


extension Equation: CustomDebugStringConvertible {
    public var debugDescription: String {
        return description
    }
}

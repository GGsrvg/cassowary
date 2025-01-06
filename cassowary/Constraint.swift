//
//  Constraint.swift
//  cassowary
//
//  Created by GGsrvg on 12/23/24.
//

import simplex_kit

public class Constraint {
    let firstAttribute: ViewAttribute
    let relation: Relation
    let secondAttribute: ViewAttribute?
    let constant: Double
    let multiplier: Double
    
    public init(
        from firstAttribute: ViewAttribute,
        is relation: Relation,
        to secondAttribute: ViewAttribute,
        constant: Double,
        multiplier: Double = 1.0
    ) {
        self.firstAttribute = firstAttribute
        self.relation = relation
        self.secondAttribute = secondAttribute
        self.constant = constant
        self.multiplier = multiplier
    }
    
    public init(
        from firstAttribute: ViewAttribute,
        is relation: Relation,
        constant: Double,
        multiplier: Double = 1.0
    ) {
//        assert([Attribute.width, Attribute.height].contains(where: { $0 == firstAttribute.attribute }))
        
        self.firstAttribute = firstAttribute
        self.relation = relation
        self.secondAttribute = nil
        self.constant = constant
        self.multiplier = multiplier
    }
    
    func getEquation() -> Equation {
        var firstExpr: simplex_kit.Expression = 1 * firstAttribute.variable
        let secontExpr: simplex_kit.Expression
        
        if let secondAttribute {
            if firstAttribute.attribute == .centerX || firstAttribute.attribute == .centerY {
                firstExpr = 0.5 * firstAttribute.variable
                secontExpr = (0.5 * firstAttribute.altVariable) +
                (-0.5 * multiplier * secondAttribute.variable) +
                (-0.5 * multiplier * secondAttribute.altVariable)
            } else {
                secontExpr = -1 * multiplier * secondAttribute.variable
            }
        } else {
            if firstAttribute.attribute == .width || firstAttribute.attribute == .height {
                secontExpr = -1 * multiplier * firstAttribute.altVariable
            } else {
                secontExpr = .number(.zero)
            }
        }
        
        return Equation(
            left: firstExpr + secontExpr,
            relation: relation,
            right: .number(Decimal(Double(constant)))
        )
    }
}

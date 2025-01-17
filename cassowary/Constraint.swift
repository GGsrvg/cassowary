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
    let priority: Priority
    
    public init(
        from firstAttribute: ViewAttribute,
        is relation: Relation,
        to secondAttribute: ViewAttribute,
        constant: Double,
        multiplier: Double = 1.0,
        priority: Priority = .required
    ) {
        let sizeAttributes: [Attribute] = [Attribute.width, Attribute.height]
        let horizontalAttributes: [Attribute] = [Attribute.left, Attribute.right, Attribute.centerX]
        let verticalAttributes: [Attribute] = [Attribute.top, Attribute.bottom, Attribute.centerY]
        
        if sizeAttributes.contains(where: { $0 == firstAttribute.attribute }) {
            assert(
                sizeAttributes.contains(where: { $0 == secondAttribute.attribute }),
                "If first attribute is width or height, second attribute must be width or height too"
            )
        }
        if horizontalAttributes.contains(where: { $0 == firstAttribute.attribute }) {
            assert(
                horizontalAttributes.contains(where: { $0 == secondAttribute.attribute }),
                "If first attribute is left or right or centerX, second attribute must be left or right or centerX too"
            )
        }
        if verticalAttributes.contains(where: { $0 == firstAttribute.attribute }) {
            assert(
                verticalAttributes.contains(where: { $0 == secondAttribute.attribute }),
                "If first attribute is top or bottom or centerY, second attribute must be top or bottom or centerY too"
            )
        }
        
        self.firstAttribute = firstAttribute
        self.relation = relation
        self.secondAttribute = secondAttribute
        self.constant = constant
        self.multiplier = multiplier
        self.priority = priority
    }
    
    public init(
        from firstAttribute: ViewAttribute,
        is relation: Relation,
        constant: Double,
        multiplier: Double = 1.0,
        priority: Priority = .required
    ) {
        assert(
            [
                Attribute.top, Attribute.left,
                Attribute.width, Attribute.height
            ].contains(where: { $0 == firstAttribute.attribute }),
            "If You use with only one attribute, first attribute must be top, left, width or height"
        )
        
        self.firstAttribute = firstAttribute
        self.relation = relation
        self.secondAttribute = nil
        self.constant = constant
        self.multiplier = multiplier
        self.priority = priority
    }
    
    func getEquation() -> Equation {
        let firstExpr: simplex_kit.Expression
        let secontExpr: simplex_kit.Expression
        
        if firstAttribute.attribute == .centerX || firstAttribute.attribute == .centerY {
            firstExpr = 0.5 * firstAttribute.variable + 0.5 * firstAttribute.altVariable
        } else {
            firstExpr = 1 * firstAttribute.variable
        }
        
        if let secondAttribute {
            if secondAttribute.attribute == .centerX || secondAttribute.attribute == .centerY {
                secontExpr = -0.5 * multiplier * secondAttribute.variable + -0.5 * multiplier * secondAttribute.altVariable
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
            right: .number(Decimal(constant))
        )
    }
}

struct ConstraintData: Hashable {
    let firstAttribute: ViewAttribute
    let secondAttribute: ViewAttribute?
}

extension Sequence where Element == Constraint {
    func keepingHighestPriority() -> [Constraint] {
        let grouped = Dictionary(grouping: self) {
            ConstraintData(
                firstAttribute: $0.firstAttribute,
                secondAttribute: $0.secondAttribute
            )
        }
        return grouped
            .values
            .compactMap { $0.max { $0.priority.value < $1.priority.value } }
    }
}

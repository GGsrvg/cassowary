//
//  ConstraintManager.swift
//  cassowary
//
//  Created by GGsrvg on 12/23/24.
//

import simplex_kit

public class ConstraintManager {
    let constraints: [Constraint]
    
    public init(
        constraints: [Constraint]
    ) {
        self.constraints = constraints
    }
    
    public func solve(rootView: View) throws {
        let constraints = self.constraints
            .lazy
            .keepingHighestPriority()
            .sorted(by: { $0.priority > $1.priority })
        // TODO: optimize
        // only one `constraints` foreach
        let allView: Set<ViewAttribute> = Set(constraints.flatMap {
            if let secondAttribute = $0.secondAttribute {
                [$0.firstAttribute, secondAttribute]
            } else {
                [$0.firstAttribute]
            }
        })
        let allVariable: Set<Variable> = Set(allView.map({ $0.variable }))
        let expressions = allVariable.map {
            simplex_kit.Expression.variable(multiplier: 1, $0)
        }
        let formula = simplex_kit.Expression.plus(expressions).optimize()
        let equations = constraints.map { $0.getEquation() }
        
        let simplex = Simplex(
            formula: formula,
            goal: .max,
            equations: equations
        )
        let solve = try simplex.solve()
        
        applyRect(for: rootView, solution: solve)
    }
    
    private func applyRect(for view: View, solution: Solution) {
        let minX = solution.constraints[view.leftAttribute.variable] ?? 0
        let maxX = solution.constraints[view.rightAttribute.variable] ?? 0
        let minY = solution.constraints[view.topAttribute.variable] ?? 0
        let maxY = solution.constraints[view.bottomAttribute.variable] ?? 0
        
        let absoluteFrame = CGRect(
            x: minX,
            y: minY,
            width: maxX - minX,
            height: maxY - minY
        )
        let relativeFrame: CGRect
        if let superView = view.superview {
            let minX = solution.constraints[superView.leftAttribute.variable] ?? 0
            let minY = solution.constraints[superView.topAttribute.variable] ?? 0
            relativeFrame = CGRect(
                x: absoluteFrame.minX - minX,
                y: absoluteFrame.minY - minY,
                width: absoluteFrame.width,
                height: absoluteFrame.height
            )
        } else {
            relativeFrame = absoluteFrame
        }
        view.frame = relativeFrame
        
        // defer
        view.subviews.forEach { applyRect(for: $0, solution: solution) }
    }
}

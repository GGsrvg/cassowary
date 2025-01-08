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
        let allView: Set<ViewAttribute> = constraints.reduce(Set<ViewAttribute>()) {
            return $0.union([$1.firstAttribute, $1.secondAttribute].compactMap{$0})
        }
        let allVariable: Set<Variable> = allView.reduce(Set<Variable>()) {
            return $0.union([$1.variable])
        }
        let formula = allVariable.reduce(.plus([]), {
            $0 + .variable(multiplier: 1, $1)
        })
        let equations = constraints.map { $0.getEquation() }
        
        let simplex = Simplex(
            formula: formula,
            goal: .max,
            equations: equations
        )
        let solve = try! simplex.solve()
        
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

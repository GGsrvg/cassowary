//
//  Simplex.swift
//  simplex
//
//  Created by GGsrvg on 10/25/24.
//

import Foundation

fileprivate let limit = 100

public class Simplex {
    
    var tableau: Tableau?
    
    public init(
        formula: Expression,
        goal: Goal = .max,
        equations: [Equation]
    ) {
        let zRow = Variable(tag: "Z")
        let bColumn = Variable(tag: "B")
        
        var __i = 0
        var rows: [Variable?] = []
        let expressions: [Equation] = equations
            .map {
                __i += 1
                let result = $0.canonical(i: __i)
                rows.append(result.1)
                return result.0
            }
        rows.append(zRow)
        
        let columns: [Variable] = expressions
            .reduce(Set<Variable>(), { partialResult, equation in
                return partialResult.union(equation.getVariables())
            })
            .map({ $0 })
            .sorted()
        + [bColumn]
        
        let table: [[Decimal]] = (expressions + [formula.getEquation() * -1])
            .map { expression in
                let l = expression.left.getVariablesAndMultiplier()
                let r = expression.right.getVariablesAndMultiplier()
                let rn = expression.right.getNumbers()
                assert(rn.count == 1)
                let vals = l.merging(r) { (current, _) in current }
                return columns.map { column in
                    if let v = vals[column] {
                        return v
                    } else {
                        if column == bColumn {
                            return rn.first!
                        } else {
                            return .zero
                        }
                    }
                }
            }
        
        
#if DEBUG
        print("Expressions:")
        print(expressions)
#endif
        
        self.tableau = Tableau(
            columns: columns,
            bColumn: bColumn,
            rows: rows,
            zRow: zRow,
            table: table,
            goal: goal,
            variablesForAnswer: formula.getVariables() + [zRow]
        )
    }
    
    public func solve() throws(SimplexError) -> Solution {
        var i = 0
        var answer: Solution! = tableau?.answer()
        while answer == nil {
            tableau = try tableau?.pivot()
            answer = tableau?.answer()
            i += 1
            if i > limit {
                throw SimplexError.muchMoreIteractions
            }
        }
        return answer
        
    }
}

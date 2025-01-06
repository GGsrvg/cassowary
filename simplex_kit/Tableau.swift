//
//  Tableau.swift
//  simplex_kit
//
//  Created by GGsrvg on 11/12/24.
//

import Foundation

struct Tableau {
    
    let columns: [Variable]
    /// last column from `columns`
    let bColumn: Variable
    
    let rows: [Variable?]
    let zRow: Variable
    
    let table: [[Decimal]]
    
    let goal: Goal
    
    let variablesForAnswer: [Variable]
    
    init(
        columns: [Variable],
        bColumn: Variable,
        rows: [Variable?],
        zRow: Variable,
        table: [[Decimal]],
        goal: Goal = .max,
        variablesForAnswer: [Variable]
    ) {
        assert(columns.last == bColumn)
        assert(rows.last == zRow)
        assert(rows.count == table.count)
        assert(columns.count == table[0].count)
        
#if DEBUG
        print("Table: \t\(table.map { "\($0)" }.joined(separator:"\n\t\t"))")
        print("Columns: \(columns)")
        print("Rows: \(rows)")
#endif
        
        self.columns = columns
        self.bColumn = bColumn
        self.rows = rows
        self.zRow = zRow
        self.table = table
        self.goal = goal
        self.variablesForAnswer = variablesForAnswer
    }
    
    func pivot() throws(SimplexError) -> Tableau {
        var table = self.table
        
        let focusColumnIndex: Int?
        let focusRowIndex: Int?
        
        if let index = rows.firstIndex(where: { variable in variable == nil }) {
            focusRowIndex = index
            focusColumnIndex = table[index].firstIndex(where: { $0.isZero == false })
        } else if table.contains(where: { decimals in decimals.last! < .zero }) {
            // проверка отрицательных значений в конце
            focusRowIndex = table[0..<table.count-1].enumerated().min(by: { $0.element.last! < $1.element.last! }).map(\.offset)
            guard let focusRowIndex else {
                throw SimplexError.cantFindSolution
            }
            let tableLastRow = table.last!
            focusColumnIndex = table[focusRowIndex][0..<self.columns.count-1].enumerated()
                .filter({ $0.element < .zero })
                .min(by: { (l, r) in
                    return abs(tableLastRow[l.offset] / l.element) < abs(tableLastRow[r.offset] / r.element)
                })
                .map(\.offset)
        } else if let lastRow = table.last,
            let _focusColumnIndex = lastRow
            .enumerated()
            .min(by: { $0.element < $1.element })
            .map(\.offset) {
                focusColumnIndex = _focusColumnIndex
            
            guard let focusColumnIndex else {
                throw SimplexError.cantFindSolution
            }
            
            focusRowIndex = table[0..<table.count-1]
                .lazy
                .enumerated()
                .compactMap({ i in
                    let focus = i.element[focusColumnIndex]
                    let element = i.element.last! / focus
                    if element.isNaN || element.isZero || element < .zero {
                        return nil
                    }
                    return (offset: i.offset, value: element)
                })
                .min(by: { (l: (offset: Int,value: Decimal), r: (offset: Int,value: Decimal))  in
                    return l.value < r.value
                })?.offset
        }
        else {
            throw SimplexError.cantFindSolution
        }
        
        guard let focusColumnIndex else {
            throw SimplexError.cantFindSolution
        }
        guard let focusRowIndex else {
            throw SimplexError.cantFindSolution
        }
        
        let focusElement = self.table[focusRowIndex][focusColumnIndex]
        
        var rows = self.rows
        rows[focusRowIndex] = columns[focusColumnIndex]
        
        table[focusRowIndex] = table[focusRowIndex].map({ $0 / focusElement })
        let focusRow = table[focusRowIndex]
        table = table.enumerated().map({ (index, row) in
            guard index != focusRowIndex else {
                return row
            }
            
            let currentFocusElement = row[focusColumnIndex]
            return row.enumerated().map({
                let element = $0.element
                let el1 = focusRow[$0.offset]
                let el2 = currentFocusElement
                let result = element - el1 * el2
                return result
            })
        })
#if DEBUG
        print("Focus: \(focusRowIndex), \(focusColumnIndex)")
#endif
        
        return Tableau(
            columns: self.columns,
            bColumn: self.bColumn,
            rows: rows,
            zRow: self.zRow,
            table: table,
            goal: self.goal,
            variablesForAnswer: self.variablesForAnswer
        )
    }
    
    func hasAnswer() -> Bool {
        return goal == .min ? hasAnswerMin() : hasAnswerMax()
    }
    
    func answer() -> Solution? {
        guard hasAnswer() else { return nil }
        
        return goal == .min ? answerMin() : answerMax()
    }
    
    func hasAnswerMin() -> Bool {
        let hasAnswerMin = table.enumerated().allSatisfy { rows in
            if rows.offset == table.count - 1 {
                return rows.element[0..<rows.element.count-1].allSatisfy({
                    return $0 <= 1e-20
                })
            }
            
            return rows.element.last! >= 1e-20
        }
        return hasAnswerMin
    }
    
    func answerMin() -> Solution? {
        var result = self.variablesForAnswer
            .reduce([Variable: Double]()) { (result, variable) in
                var result = result
                if let rowIndex = rows.firstIndex(of: variable) {
                    result[variable] = NSDecimalNumber(decimal: table[rowIndex].last!).doubleValue
                } else {
                    result[variable] = .zero
                }
                return result
            }
        let objective = result.removeValue(forKey: zRow)!
        
        return Solution(
            objective: objective,
            constraints: result
        )
    }
    
    func hasAnswerMax() -> Bool {
        let result = table.enumerated().allSatisfy { rows in
            if rows.offset == table.count - 1 {
                return rows.element[0..<rows.element.count-1].allSatisfy({
                    return $0 >= -1e-20
                })
            }
            
            return rows.element.last! >= -1e-20
        }
        return result
    }
    
    func answerMax() -> Solution? {
        var result = self.variablesForAnswer
            .reduce([Variable: Double]()) { (result, variable) in
                var result = result
                if let rowIndex = rows.firstIndex(of: variable) {
                    result[variable] = NSDecimalNumber(decimal: table[rowIndex].last!).doubleValue
                } else {
                    result[variable] = .zero
                }
                return result
            }
        let objective = result.removeValue(forKey: zRow)!
        
        return Solution(
            objective: objective,
            constraints: result
        )
    }
}

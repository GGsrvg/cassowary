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
    
    public init(tableau: Tableau) {
        self.tableau = tableau
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

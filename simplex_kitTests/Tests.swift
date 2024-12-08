//
//  Tests.swift
//  simplex_kitTests
//
//  Created by GGsrvg on 11/6/24.
//

import XCTest
@testable import simplex_kit

final class Tests: XCTestCase {
    func test1() {
        // https://math.libretexts.org/Bookshelves/Applied_Mathematics/Applied_Finite_Mathematics_(Sekhon_and_Bloom)/04%3A_Linear_Programming_The_Simplex_Method/4.02%3A_Maximization_By_The_Simplex_Method/4.2.01%3A_Maximization_By_The_Simplex_Method_(Exercises)
        // 1
        let t = Tableau(
            formula: .plus([
                .variable(multiplier: 1, x1),
                .variable(multiplier: 2, x2),
                .variable(multiplier: 3, x3),
            ]),
            equations: [
                .init(
                    left: .plus([
                        .variable(multiplier: 1, x1),
                        .variable(multiplier: 1, x2),
                        .variable(multiplier: 1, x3),
                    ]),
                    relation: .lessOrEqual,
                    right: .number(12)
                ),
                .init(
                    left: .plus([
                        .variable(multiplier: 2, x1),
                        .variable(multiplier: 1, x2),
                        .variable(multiplier: 3, x3),
                    ]),
                    relation: .lessOrEqual,
                    right: .number(18)
                ),
            ]
        )
        let s = Simplex(tableau: t)
        let answer = try? s.solve()
        let solution = Solution(objective: 27, constraints: [x1:0, x2: 9, x3: 3])
        print("Solution: ans = \(answer!)")
        print("Answer is correct: \(answer == solution)")
        XCTAssert(answer == solution)
    }
    
    func test2() {
        //  https://math.libretexts.org/Bookshelves/Applied_Mathematics/Applied_Finite_Mathematics_(Sekhon_and_Bloom)/04%3A_Linear_Programming_The_Simplex_Method/4.02%3A_Maximization_By_The_Simplex_Method/4.2.01%3A_Maximization_By_The_Simplex_Method_(Exercises)
        // 2
        let t = Tableau(
            formula: .plus([
                .variable(multiplier: 1, x1),
                .variable(multiplier: 2, x2),
                .variable(multiplier: 1, x3),
            ]),
            equations: [
                .init(
                    left: .plus([
                        .variable(multiplier: 1, x1),
                        .variable(multiplier: 1, x2),
                    ]),
                    relation: .lessOrEqual,
                    right: .number(3)
                ),
                .init(
                    left: .plus([
                        .variable(multiplier: 1, x2),
                        .variable(multiplier: 1, x3),
                    ]),
                    relation: .lessOrEqual,
                    right: .number(4)
                ),
                .init(
                    left: .plus([
                        .variable(multiplier: 1, x1),
                        .variable(multiplier: 1, x3),
                    ]),
                    relation: .lessOrEqual,
                    right: .number(5)
                ),
            ]
        )
        let s = Simplex(tableau: t)
        let answer = try? s.solve()
        let solution = Solution(objective: 7, constraints: [x1: 0, x2: 3, x3: 1])
        print("Solution: ans = \(answer!)")
        print("Answer is correct: \(answer == solution)")
        XCTAssert(answer == solution)
    }
    
    func test3() {
        /// НЕ ИМЕЕТ РЕШЕНИЯ
        // https://portal.abuad.edu.ng/lecturer/documents/1586166095Linear_Programming.pdf
        // 33
        let t = Tableau(
            formula: .plus([
                .variable(multiplier: 1, x1),
                .variable(multiplier: 2, x2),
            ]),
            equations: [
                .init(
                    left: .plus([
                        .variable(multiplier: 1, x1),
                        .variable(multiplier: -3, x2),
                    ]),
                    relation: .lessOrEqual,
                    right: .number(1)
                ),
                .init(
                    left: .plus([
                        .variable(multiplier: -1, x1),
                        .variable(multiplier: 2, x2),
                    ]),
                    relation: .lessOrEqual,
                    right: .number(4)
                ),
            ]
        )
        let s = Simplex(tableau: t)
        do {
            let answer = try s.solve()
            let solution = Solution(objective: 11, constraints: [x1: 0, x2: 3, x3: 1])
            print("Solution: ans = \(answer)")
            print("Answer is correct: \(answer == solution)")
            XCTAssert(answer == solution)
        } catch {
            let isCorrectError = error == .cantFindSolution
            XCTAssert(isCorrectError)
        }
    }
    
    func test4() {
        // https://faculty.ksu.edu.sa/sites/default/files/exercises_4_or122-simplex_method.pdf
        // 1
        let t = Tableau(
            formula: .plus([
                .variable(multiplier: 3, x1),
                .variable(multiplier: 4, x2),
            ]),
            equations: [
                .init(
                    left: .plus([
                        .variable(multiplier: 15, x1),
                        .variable(multiplier: 10, x2),
                    ]),
                    relation: .lessOrEqual,
                    right: .number(300)
                ),
                .init(
                    left: .plus([
                        .variable(multiplier: 2.5, x1),
                        .variable(multiplier: 5, x2),
                    ]),
                    relation: .lessOrEqual,
                    right: .number(110)
                ),
            ]
        )
        let s = Simplex(tableau: t)
        let answer = try? s.solve()
        let solution = Solution(objective: 96, constraints: [x1: 8, x2: 18])
        print("Solution: ans = \(answer!)")
        print("Answer is correct: \(answer == solution)")
        XCTAssert(answer == solution)
    }
    
    func test5() {
        // http://edshare.soton.ac.uk/2458/1/MA230exam98_1.pdf
        // a
        let t = Tableau(
            formula: .plus([
                .variable(multiplier: -2, x1),
                .variable(multiplier: 7, x2),
                .variable(multiplier: 4, x3),
            ]),
            equations: [
                .init(
                    left: .plus([
                        .variable(multiplier: 2, x1),
                        .variable(multiplier: -5, x2),
                    ]),
                    relation: .lessOrEqual,
                    right: .number(11)
                ),
                .init(
                    left: .plus([
                        .variable(multiplier: -1, x1),
                        .variable(multiplier: 3, x2),
                        .variable(multiplier: 1, x3),
                    ]),
                    relation: .equal,
                    right: .number(7)
                ),
                .init(
                    left: .plus([
                        .variable(multiplier: 1, x1),
                        .variable(multiplier: -8, x2),
                        .variable(multiplier: 4, x3),
                    ]),
                    relation: .greaterOrEqual,
                    right: .number(33)
                ),
            ]
        )
        let s = Simplex(tableau: t)
        let answer = try? s.solve()
        let solution = Solution(objective: 39, constraints: [x1: 13, x2: 3, x3: 11])
        print("Solution: ans = \(answer!)")
        print("Answer is correct: \(answer == solution)")
        XCTAssert(answer == solution)
    }
    
    func test6() {
        ///https://www.youtube.com/watch?v=XwORAaG3ZmI&list=PL3pwgz7R-DSGi9K3jnXj-NmnkmIx0Vg5P&index=9
        let t = Tableau(
            formula: .plus([
                .variable(multiplier: 5, x1),
                .variable(multiplier: -6, x2),
                .variable(multiplier: 4, x3),
                .variable(multiplier: 4, x4),
                .variable(multiplier: 5, x5),
                .variable(multiplier: -45, x6),
            ]),
            goal: .max,
            equations: [
                .init(
                    left: .plus([
                        .variable(multiplier: 3, x1),
                        .variable(multiplier: -2, x2),
                        .variable(multiplier: 3, x3),
                        .variable(multiplier: 38, x4),
                        .variable(multiplier: 13, x5),
                        .variable(multiplier: -29, x6),
                    ]),
                    relation: .equal,
                    right: .number(16)
                ),
                .init(
                    left: .plus([
                        .variable(multiplier: 2, x1),
                        .variable(multiplier: 5, x2),
                        .variable(multiplier: -4, x3),
                        .variable(multiplier: -30, x4),
                        .variable(multiplier: -3, x5),
                        .variable(multiplier: 23, x6),
                    ]),
                    relation: .equal,
                    right: .number(6)
                ),
                .init(
                    left: .plus([
                        .variable(multiplier: -5, x1),
                        .variable(multiplier: 3, x2),
                        .variable(multiplier: -1, x3),
                        .variable(multiplier: -42, x4),
                        .variable(multiplier: -10, x5),
                        .variable(multiplier: 24, x6),
                    ]),
                    relation: .equal,
                    right: .number(-8)
                ),
            ]
        )
        let s = Simplex(tableau: t)
        let answer = try? s.solve()
        let solution = Solution(objective: 11, constraints: [x1: 3, x2: 4, x3: 5, x4: 0, x5: 0, x6: 0])
        print("Solution: ans = \(answer!)")
        print("Answer is correct: \(answer == solution)")
        XCTAssert(answer == solution)
    }
    
    func test7() {
        ///https://www.youtube.com/watch?v=XwORAaG3ZmI&list=PL3pwgz7R-DSGi9K3jnXj-NmnkmIx0Vg5P&index=8
        let t = Tableau(
            formula: .plus([
                .variable(multiplier: 2, x1),
                .variable(multiplier: -7, x2),
                .variable(multiplier: -9, x3),
            ]),
            goal: .max,
            equations: [
                .init(
                    left: .plus([
                        .variable(multiplier: -4, x1),
                        .variable(multiplier: 5, x2),
                        .variable(multiplier: 6, x3),
                    ]),
                    relation: .greaterOrEqual,
                    right: .number(455)
                ),
                .init(
                    left: .plus([
                        .variable(multiplier: -7, x1),
                        .variable(multiplier: 7, x2),
                        .variable(multiplier: 8, x3),
                    ]),
                    relation: .greaterOrEqual,
                    right: .number(333)
                ),
                .init(
                    left: .plus([
                        .variable(multiplier: -11, x1),
                        .variable(multiplier: 1, x2),
                        .variable(multiplier: 5, x3),
                    ]),
                    relation: .greaterOrEqual,
                    right: .number(300)
                ),
            ]
        )
        let s = Simplex(tableau: t)
        let answer = try? s.solve()
        let solution = Solution(objective: -670, constraints: [x1: 0, x2: 25, x3: 55])
        print("Solution: ans = \(answer!)")
        print("Answer is correct: \(answer == solution)")
        XCTAssert(answer == solution)
    }
    
    func test8() {
        ///https://www.youtube.com/watch?v=e66z38cWD-w&list=PL3pwgz7R-DSGi9K3jnXj-NmnkmIx0Vg5P&index=7
        let t = Tableau(
            formula: .plus([
                .variable(multiplier: -1, x1),
                .variable(multiplier: 8, x2),
                .variable(multiplier: 3, x3),
            ]),
            goal: .min,
            equations: [
                .init(
                    left: .plus([
                        .variable(multiplier: 3, x1),
                        .variable(multiplier: 1, x2),
                        .variable(multiplier: 2, x3),
                    ]),
                    relation: .greaterOrEqual,
                    right: .number(6)
                ),
                .init(
                    left: .plus([
                        .variable(multiplier: 1, x1),
                        .variable(multiplier: 1, x2),
                        .variable(multiplier: 1, x3),
                    ]),
                    relation: .greaterOrEqual,
                    right: .number(4)
                ),
                .init(
                    left: .plus([
                        .variable(multiplier: -1, x1),
                        .variable(multiplier: 3, x2),
                        .variable(multiplier: -1, x3),
                    ]),
                    relation: .greaterOrEqual,
                    right: .number(4)
                ),
            ]
        )
        let s = Simplex(tableau: t)
        var answer: Solution?
        measure {
            answer = try? s.solve()
        }
        let solution = Solution(objective: 14, constraints: [x1: 2, x2: 2, x3: 0])
        print("Solution: ans = \(answer!)")
        print("Answer is correct: \(answer == solution)")
        XCTAssert(answer == solution)
    }
}

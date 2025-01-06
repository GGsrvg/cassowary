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
        let s = Simplex(
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
            ])
        do {
            let answer = try s.solve()
            let solution = Solution(objective: 27, constraints: [x1:0, x2: 9, x3: 3])
            print("Solution: ans = \(answer)")
            print("Answer is correct: \(answer == solution)")
            XCTAssert(answer == solution)
        } catch {
            print("Error: \(error)")
            XCTFail("Error: \(error)")
        }
    }
    
    func test2() {
        //  https://math.libretexts.org/Bookshelves/Applied_Mathematics/Applied_Finite_Mathematics_(Sekhon_and_Bloom)/04%3A_Linear_Programming_The_Simplex_Method/4.02%3A_Maximization_By_The_Simplex_Method/4.2.01%3A_Maximization_By_The_Simplex_Method_(Exercises)
        // 2
        let s = Simplex(
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
            ])
        let answer = try! s.solve()
        let solution = Solution(objective: 7, constraints: [x1: 0, x2: 3, x3: 1])
        print("Solution: ans = \(answer)")
        print("Answer is correct: \(answer == solution)")
        XCTAssert(answer == solution)
    }
    
    func test3() {
        /// НЕ ИМЕЕТ РЕШЕНИЯ
        // https://portal.abuad.edu.ng/lecturer/documents/1586166095Linear_Programming.pdf
        // 33
        let s = Simplex(
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
            ])
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
        let s = Simplex(
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
            ])
        let answer = try! s.solve()
        let solution = Solution(objective: 96, constraints: [x1: 8, x2: 18])
        print("Solution: ans = \(answer)")
        print("Answer is correct: \(answer == solution)")
        XCTAssert(answer == solution)
    }
    
    func test5() {
        // http://edshare.soton.ac.uk/2458/1/MA230exam98_1.pdf
        // a
        let s = Simplex(
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
            ])
        let answer = try! s.solve()
        let solution = Solution(objective: 39, constraints: [x1: 13, x2: 3, x3: 11])
        print("Solution: ans = \(answer)")
        print("Answer is correct: \(answer == solution)")
        XCTAssert(answer == solution)
    }
    
    func test6() {
        ///https://www.youtube.com/watch?v=XwORAaG3ZmI&list=PL3pwgz7R-DSGi9K3jnXj-NmnkmIx0Vg5P&index=9
        let s = Simplex(
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
            ])
        let answer = try! s.solve()
        let solution = Solution(objective: 11, constraints: [x1: 3, x2: 4, x3: 5, x4: 0, x5: 0, x6: 0])
        print("Solution: ans = \(answer)")
        print("Answer is correct: \(answer == solution)")
        XCTAssert(answer == solution)
    }
    
    func test7() {
        ///https://www.youtube.com/watch?v=XwORAaG3ZmI&list=PL3pwgz7R-DSGi9K3jnXj-NmnkmIx0Vg5P&index=8
        let s = Simplex(
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
            ])
        let answer = try! s.solve()
        let solution = Solution(objective: -670, constraints: [x1: 0, x2: 25, x3: 55])
        print("Solution: ans = \(answer)")
        print("Answer is correct: \(answer == solution)")
        XCTAssert(answer == solution)
    }
    
    func test8() {
        ///https://www.youtube.com/watch?v=e66z38cWD-w&list=PL3pwgz7R-DSGi9K3jnXj-NmnkmIx0Vg5P&index=7
        let s = Simplex(
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
            ])
        var answer: Solution?
        measure {
            answer = try! s.solve()
        }
        let solution = Solution(objective: 14, constraints: [x1: 2, x2: 2, x3: 0])
        print("Solution: ans = \(answer!)")
        print("Answer is correct: \(answer == solution)")
        XCTAssert(answer == solution)
    }
    
    func test9() {
        let s = Simplex(
            formula: 1 * x1 + 1 * x2 + 1 * x3 + 1 * x4 + 1 * x5 + 1 * x6 + 1 * x7 + 1 * x8,
            goal: .max,
            equations: [
                .init(
                    left: 1 * x1 + -1 * x5,
                    relation: .equal,
                    right: .number(14)
                ),
                .init(
                    left: -1 * x2 + 1 * x6,// + -1 * x5,
                    relation: .equal,
                    right: .number(14)
                ),
                .init(
                    left: 1 * x3 + -1 * x7,
                    relation: .equal,
                    right: .number(10)
                ),
                .init(
                    left: -1 * x4 + 1 * x8,// + -1 * x7,
                    relation: .equal,
                    right: .number(90)
                ),
                .init(
                    left: 1 * x5,
                    relation: .equal,
                    right: .number(0)
                ),
                .init(
                    left: 1 * x7,
                    relation: .equal,
                    right: .number(0)
                ),
                .init(
                    left: 1 * x6 + -1 * x5,
                    relation: .equal,
                    right: .number(200)
                ),
                .init(
                    left: 1 * x8 + 1 * x7,
                    relation: .equal,
                    right: .number(800)
                ),
            ])
        do {
            let answer = try s.solve()
            let solution = Solution(
                objective: 1920,
                constraints: [
                    x1: 14,
                    x2: 186,
                    x3: 10,
                    x4: 710,
                    x5: 0,
                    x6: 200,
                    x7: 0,
                    x8: 800
                ]
            )
            print("Solution: ans = \(answer)")
            print("Answer is correct: \(answer == solution)")
            XCTAssert(answer == solution)
        } catch {
            print("Error: \(error)")
            XCTFail("Error: \(error)")
        }
    }
    
    /*
     v1 - x1..x4
     v2 - x5..x8
     v3 - x9..x12

     v1_left   - x1
     v1_right  - x2
     v1_top    - x3
     v1_bottom - x4
     v2_left   - x5
     v2_right  - x6
     v2_top    - x7
     v2_bottom - x8
     v3_left   - x9
     v3_right  - x10
     v3_top    - x11
     v3_bottom - x12

     v3 contains v2, v2 contains v1

     v3 frame (0, 0, 100, 100)
     v2 margins (10, 10, 10, 10)
     v1 margins (12, 12, 12, 12)
     */
    /*
     left: -1 * x10 + 1 * x6, relation: .equal, right: .number(12)
     as like
     v2.right.constraint(to: v3.right, constant: 12) =>
     v2_right = multiplier * v3_right + constant =>
     v2_right - multiplier * v3_right = constant =>
     - multiplier * v3_right + v2_right = constant =>
     (-1 * multiplier) * v3_right + v2_right = constant =>
     */
    func test10() {
        let s = Simplex(
            formula: 1 * x1 + 1 * x2 + 1 * x3 + 1 * x4
                + 1 * x5 + 1 * x6 + 1 * x7 + 1 * x8
                + 1 * x9 + 1 * x10 + 1 * x11 + 1 * x12,
            goal: .max,
            equations: [
                // v3
                .init(
                    left: 1 * x9 + -1 * x5, relation: .equal, right: .number(12)
                ),
                .init(
                    left: -1 * x10 + 1 * x6, relation: .equal, right: .number(12)
                ),
                .init(
                    left: 1 * x11 + -1 * x7, relation: .equal, right: .number(12)
                ),
                .init(
                    left: -1 * x12 + 1 * x8, relation: .equal, right: .number(12)
                ),
                // v2
                .init(
                    left: 1 * x5 + -1 * x1, relation: .equal, right: .number(10)
                ),
                .init(
                    left: -1 * x6 + 1 * x2, relation: .equal, right: .number(10)
                ),
                .init(
                    left: 1 * x7 + -1 * x3, relation: .equal, right: .number(10)
                ),
                .init(
                    left: -1 * x8 + 1 * x4, relation: .equal, right: .number(10)
                ),
                // v1
                .init(
                    left: 1 * x1, relation: .equal, right: .number(0)
                ),
                .init(
                    left: 1 * x3, relation: .equal, right: .number(0)
                ),
                .init(
                    left: 1 * x2 + -1 * x1, relation: .equal,
                    right: .number(100)
                ),
                .init(
                    left: 1 * x4 + -1 * x3, relation: .equal,
                    right: .number(100)
                ),
            ])
        measure {
            do {
                let answer = try s.solve()
                let solution = Solution(
                    objective: 600,
                    constraints: [
                        x1:     0,
                        x2:     100,
                        x3:     0,
                        x4:     100,
                        x5:     10,
                        x6:     90,
                        x7:     10,
                        x8:     90,
                        x9:     22,
                        x10:    78,
                        x11:    22,
                        x12:    78,
                    ]
                )
                print("Solution: ans = \(answer)")
                print("Answer is correct: \(answer == solution)")
                XCTAssert(answer == solution)
            } catch {
                print("Error: \(error)")
                XCTFail("Error: \(error)")
            }
        }
    }
}

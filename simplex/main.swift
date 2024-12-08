//
//  main.swift
//  simplex
//
//  Created by GGsrvg on 10/25/24.
//

import Foundation
import simplex_kit

let x1 = Variable(tag: "x1")
let x2 = Variable(tag: "x2")
let x3 = Variable(tag: "x3")
let x4 = Variable(tag: "x4")
let x5 = Variable(tag: "x5")
let x6 = Variable(tag: "x6")
let x7 = Variable(tag: "x7")
let x8 = Variable(tag: "x8")
let x9 = Variable(tag: "x9")
//let equation = Equation(
//    left: .plus([
//        .variable(multiplier: 10, .init(tag: "x1")),
//        .variable(multiplier: 2, .init(tag: "x2")),
//        .variable(multiplier: -1, .init(tag: "x3")),
//    ]),
//    relation: .lessOrEqual,
//    right: .number(.zero)
//)
//let t = Tableau(
//    formula: .plus([
//        .variable(multiplier: 2, x1),
//        .variable(multiplier: 3, x2),
//        .variable(multiplier: -1, x4),
//    ]),
//    equations: [
//        .init(
//            left: .plus([
//                .variable(multiplier: 2, x1),
//                .variable(multiplier: -1, x2),
//                .variable(multiplier: -2, x4),
//                .variable(multiplier: 1, x5),
//            ]),
//            relation: .equal,
//            right: .number(16)
//        ),
//        .init(
//            left: .plus([
//                .variable(multiplier: 3, x1),
//                .variable(multiplier: 2, x2),
//                .variable(multiplier: 1, x3),
//                .variable(multiplier: -3, x4),
//            ]),
//            relation: .equal,
//            right: .number(18)
//        ),
//        .init(
//            left: .plus([
//                .variable(multiplier: -1, x1),
//                .variable(multiplier: 3, x2),
//                .variable(multiplier: 4, x4),
//                .variable(multiplier: 1, x6),
//            ]),
//            relation: .equal,
//            right: .number(24)
//        ),
//    ]
//)
//print("Ex: \(equation.canonical())")
// https://math.libretexts.org/Bookshelves/Applied_Mathematics/Applied_Finite_Mathematics_(Sekhon_and_Bloom)/04%3A_Linear_Programming_The_Simplex_Method/4.02%3A_Maximization_By_The_Simplex_Method/4.2.01%3A_Maximization_By_The_Simplex_Method_(Exercises)
//let t = Tableau1(
//    formula: .plus([
//        .variable(multiplier: 1, x1),
//        .variable(multiplier: 2, x2),
//        .variable(multiplier: 3, x3),
//    ]),
//    equations: [
//        .init(
//            left: .plus([
//                .variable(multiplier: 1, x1),
//                .variable(multiplier: 1, x2),
//                .variable(multiplier: 1, x3),
//            ]),
//            relation: .lessOrEqual,
//            right: .number(12)
//        ),
//        .init(
//            left: .plus([
//                .variable(multiplier: 2, x1),
//                .variable(multiplier: 1, x2),
//                .variable(multiplier: 3, x3),
//            ]),
//            relation: .lessOrEqual,
//            right: .number(18)
//        ),
//    ]
//)
//let s = Simplex(tableau: t)
//let answer = s.solve()
//print("Answer is correct: \(answer == [x1:0, x2: 9, x3: 3])")
//let t2 = Tableau2(
//    formula: .plus([
//        .variable(multiplier: 1, x1),
//        .variable(multiplier: 2, x2),
//        .variable(multiplier: 1, x3),
//    ]),
//    equations: [
//        .init(
//            left: .plus([
//                .variable(multiplier: 1, x1),
//                .variable(multiplier: 1, x2),
//            ]),
//            relation: .lessOrEqual,
//            right: .number(3)
//        ),
//        .init(
//            left: .plus([
//                .variable(multiplier: 1, x2),
//                .variable(multiplier: 1, x3),
//            ]),
//            relation: .lessOrEqual,
//            right: .number(4)
//        ),
//        .init(
//            left: .plus([
//                .variable(multiplier: 1, x1),
//                .variable(multiplier: 1, x3),
//            ]),
//            relation: .lessOrEqual,
//            right: .number(5)
//        ),
//    ]
//)
//let s2 = Simplex(tableau: t2)
//let answer2 = s2.solve()
//print("Answer is correct: \(answer2 == [x1:1, x2: 9, x3: 3])")
////https://www.youtube.com/watch?v=DW2MtizEijs&list=PL3pwgz7R-DSGi9K3jnXj-NmnkmIx0Vg5P&index=5
//let t3 = Tableau2(
//    formula: .plus([
//        .variable(multiplier: 8, x1),
//        .variable(multiplier: 6, x2),
//        .variable(multiplier: 3, x3),
//    ]),
//    equations: [
//        .init(
//            left: .plus([
//                .variable(multiplier: 5, x1),
//                .variable(multiplier: 3, x2),
//                .variable(multiplier: 4, x3),
//            ]),
//            relation: .lessOrEqual,
//            right: .number(960)
//        ),
//        .init(
//            left: .plus([
//                .variable(multiplier: 4, x1),
//                .variable(multiplier: 2, x2),
//                .variable(multiplier: 3, x3),
//            ]),
//            relation: .lessOrEqual,
//            right: .number(860)
//        ),
//        .init(
//            left: .plus([
//                .variable(multiplier: 3, x1),
//                .variable(multiplier: 4, x2),
//                .variable(multiplier: 2, x3),
//            ]),
//            relation: .lessOrEqual,
//            right: .number(752)
//        ),
//    ]
//)
//let s3 = Simplex(tableau: t3)
//let answer3 = s3.solve()
//print("Answer is correct: \(answer3 == Solution(objective: 1632, constraints: [x1: 144, x2: 80, x3: 0]))")
///https://www.youtube.com/watch?v=AzWsh4TmOQ4&list=PL3pwgz7R-DSGi9K3jnXj-NmnkmIx0Vg5P&index=6
let t3 = Tableau(
    formula: .plus([
        .variable(multiplier: 5, x1),
        .variable(multiplier: 3, x2),
        .variable(multiplier: 6, x3),
    ]),
    equations: [
        .init(
            left: .plus([
                .variable(multiplier: 1, x1),
                .variable(multiplier: 1, x2),
                .variable(multiplier: 1, x3),
            ]),
            relation: .lessOrEqual,
            right: .number(6)
        ),
        .init(
            left: .plus([
                .variable(multiplier: 2, x1),
                .variable(multiplier: -1, x2),
                .variable(multiplier: 3, x3),
            ]),
            relation: .lessOrEqual,
            right: .number(9)
        ),
        .init(
            left: .plus([
                .variable(multiplier: 3, x1),
                .variable(multiplier: 1, x2),
                .variable(multiplier: 2, x3),
            ]),
            relation: .greaterOrEqual,
            right: .number(1)
        ),
    ]
)
let s3 = Simplex(tableau: t3)
let answer3 = try s3.solve()
print("Answer is correct: \(answer3 == Solution(objective: 117/4, constraints: [x1: 0, x2: 9/4, x3: 15/4]))")


//let t3 = Tableau2(
//    formula: .plus([
//        .variable(multiplier: 1, x1),
//        .variable(multiplier: 1, x2),
//        .variable(multiplier: 1, x3),
//        .variable(multiplier: 1, x4),
//        .variable(multiplier: 1, x5),
//        .variable(multiplier: 1, x6),
//        .variable(multiplier: 1, x7),
//        .variable(multiplier: 1, x8),
//    ]),
//    goal: .min,
//    equations: [
//        .init(
//            left: .plus([
//                .variable(multiplier: 1, x1),
//                .variable(multiplier: 1, x5),
//            ]),
//            relation: .lessOrEqual,
//            right: .number(14)
//        ),
//        .init(
//            left: .plus([
//                .variable(multiplier: 1, x6),
//                .variable(multiplier: -1, x2),
//            ]),
//            relation: .lessOrEqual,
//            right: .number(14)
//        ),
//        .init(
//            left: .plus([
//                .variable(multiplier: 1, x3),
//                .variable(multiplier: 1, x7),
//            ]),
//            relation: .lessOrEqual,
//            right: .number(10)
//        ),
//        .init(
//            left: .plus([
//                .variable(multiplier: 1, x8),
//                .variable(multiplier: -1, x4),
//            ]),
//            relation: .lessOrEqual,
//            right: .number(90)
//        ),
//        .init(
//            left: .plus([
//                .variable(multiplier: 1, x5),
//            ]),
//            relation: .lessOrEqual,
//            right: .number(0)
//        ),
//        .init(
//            left: .plus([
//                .variable(multiplier: 1, x6),
//            ]),
//            relation: .lessOrEqual,
//            right: .number(0)
//        ),
//        .init(
//            left: .plus([
//                .variable(multiplier: 1, x7),
//            ]),
//            relation: .lessOrEqual,
//            right: .number(200)
//        ),
//        .init(
//            left: .plus([
//                .variable(multiplier: 1, x8),
//            ]),
//            relation: .lessOrEqual,
//            right: .number(800)
//        ),
//    ]
//)
//let s3 = Simplex(tableau: t3)
//let answer3 = s3.solve()
//print("Solution: ans = \(answer3)")
//print("Answer is correct: \(answer3 == Solution(objective: -670, constraints: [x1: 0, x2: 25, x3: 55]))")


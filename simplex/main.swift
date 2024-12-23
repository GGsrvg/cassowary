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

let s3 = Simplex(
    formula: 1 * x1 + 1 * x2 + 1 * x3 + 1 * x4 + 1 * x5 + 1 * x6 + 1 * x7 + 1 * x8,
    goal: .max,
    equations: [
        .init(
            left: 1 * x1 + 1 * x5,
            relation: .equal,
            right: .number(14)
        ),
        .init(
            left: -1 * x2 + 1 * x6,
            relation: .equal,
            right: .number(14)
        ),
        .init(
            left: 1 * x3 + 1 * x7,
            relation: .equal,
            right: .number(10)
        ),
        .init(
            left: -1 * x4 + 1 * x8,
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
            left: 1 * x6,
            relation: .equal,
            right: .number(200)
        ),
        .init(
            left: 1 * x8,
            relation: .equal,
            right: .number(800)
        ),
    ])
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
do {
    let answer3 = try s3.solve()
    print("Solution: ans = \(answer3)")
    print("Answer is correct: \(answer3 == solution)")
} catch {
    print("Error: \(error)")
}

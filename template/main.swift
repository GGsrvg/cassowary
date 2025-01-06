//
//  main.swift
//  simplex
//
//  Created by GGsrvg on 10/25/24.
//

import Foundation
import simplex_kit
import cassowary
import AppKit

let v1 = NSView()
let v2 = NSView()
v1.addSubview(v2)

let manager = ConstraintManager(
    constraints: [
        .init(from: v2.leftAttribute, is: .equal, to: v1.leftAttribute, constant: 14),
        .init(from: v2.rightAttribute, is: .equal, to: v1.rightAttribute, constant: 14),
        .init(from: v2.topAttribute, is: .equal, to: v1.topAttribute, constant: 10),
        .init(from: v2.bottomAttribute, is: .equal, to: v1.bottomAttribute, constant: 90),
        .init(from: v1.topAttribute, is: .equal, constant: 0),
        .init(from: v1.leftAttribute, is: .equal, constant: 0),
        .init(from: v1.rightAttribute, is: .equal, to: v1.leftAttribute, constant: 200),
        .init(from: v1.bottomAttribute, is: .equal, to: v1.topAttribute, constant: 800),
    ]
)
try! manager.solve(rootView: v1)

print("V1 frame: \(v1.frame)")
print("V2 frame: \(v2.frame)")

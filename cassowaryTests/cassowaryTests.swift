//
//  cassowaryTests.swift
//  cassowaryTests
//
//  Created by GGsrvg on 12/23/24.
//

import Testing
#if os(iOS)
import UIKit
typealias View = UIView 
#else
import AppKit
typealias View = NSView
#endif
@testable import cassowary

@Suite struct cassowaryTests {

    @MainActor
    @Test func example() throws {
        let v1 = UIView()
        let v2 = UIView()
        v1.accessibilityIdentifier = "x1"
        v2.accessibilityIdentifier = "x2"
        
        v1.addSubview(v2)
        
        let manager = ConstraintManager(
            constraints: [
                .init(from: v2.leftAttribute, is: .equal, to: v1.leftAttribute, constant: 14),
                .init(from: v1.rightAttribute, is: .equal, to: v2.rightAttribute, constant: 14),
                .init(from: v2.topAttribute, is: .equal, to: v1.topAttribute, constant: 10),
                .init(from: v1.bottomAttribute, is: .equal, to: v2.bottomAttribute, constant: 90),
                .init(from: v1.topAttribute, is: .equal, constant: 100),
                .init(from: v1.leftAttribute, is: .equal, constant: 100),
                .init(from: v1.widthAttribute, is: .equal, constant: 200),
                .init(from: v1.heightAttribute, is: .equal, constant: 800),
            ]
        )
        try! manager.solve(rootView: v1)

        print("V1 frame: \(v1.frame)")
        print("V2 frame: \(v2.frame)")
        #expect(1.0 == 2.0 / 2.0)
    }

}

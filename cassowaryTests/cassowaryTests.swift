//
//  cassowaryTests.swift
//  cassowaryTests
//
//  Created by GGsrvg on 12/23/24.
//

import Testing
@testable import cassowary

@Suite struct cassowaryTests {

    @MainActor
    @Test func example() throws {
        let v1 = View()
        let v2 = View()
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

        #expect(v1.frame == .init(x: 100, y: 100, width: 200, height: 800))
        #expect(v2.frame == .init(x: 14, y: 10, width: 172, height: 700))
    }
    
    @MainActor
    @Test func example2() {
        let v1 = View()
        let v2 = View()
        v1.accessibilityIdentifier = "x1"
        v2.accessibilityIdentifier = "x2"
        
        v1.addSubview(v2)
        
        let manager = ConstraintManager(
            constraints: [
                .init(from: v2.leftAttribute, is: .equal, to: v1.leftAttribute, constant: 14),
                .init(from: v1.rightAttribute, is: .equal, to: v2.rightAttribute, constant: 14),
                .init(from: v2.topAttribute, is: .equal, to: v1.topAttribute, constant: 10),
//                .init(from: v1.bottomAttribute, is: .equal, to: v2.bottomAttribute, constant: 90, priority: .low),
                .init(from: v1.bottomAttribute, is: .equal, to: v2.bottomAttribute, constant: 190, priority: .high),
                .init(from: v1.topAttribute, is: .equal, constant: 100),
                .init(from: v1.leftAttribute, is: .equal, constant: 100),
                .init(from: v1.widthAttribute, is: .equal, constant: 200),
                .init(from: v1.heightAttribute, is: .equal, constant: 800),
            ]
        )
        try! manager.solve(rootView: v1)
        
        #expect(v1.frame == .init(x: 100, y: 100, width: 200, height: 800))
        #expect(v2.frame == .init(x: 14, y: 10, width: 172, height: 600))
    }
    
    @MainActor
    @Test func example3() throws {
        let v1 = View()
        let v2 = View()
        v1.accessibilityIdentifier = "x1"
        v2.accessibilityIdentifier = "x2"
        
        v1.addSubview(v2)
        
        let manager = ConstraintManager(
            constraints: [
                .init(from: v2.leftAttribute, is: .equal, to: v1.leftAttribute, constant: 14),
                
                // if it has high priorite then v2.width will be equal 172
                .init(from: v1.rightAttribute, is: .equal, to: v2.rightAttribute, constant: 14, priority: .medium),
                // if it has high priorite then v2.width will be equal 175
                .init(from: v2.widthAttribute, is: .equal, constant: 175, priority: .required),
                
                .init(from: v2.topAttribute, is: .equal, to: v1.topAttribute, constant: 10),
                .init(from: v1.bottomAttribute, is: .equal, to: v2.bottomAttribute, constant: 90),
                .init(from: v1.topAttribute, is: .equal, constant: 100),
                .init(from: v1.leftAttribute, is: .equal, constant: 100),
                .init(from: v1.widthAttribute, is: .equal, constant: 200),
                .init(from: v1.heightAttribute, is: .equal, constant: 800),
            ]
        )
        try manager.solve(rootView: v1)
        
        print("v1 frane: \(v1.frame)")
        print("v2 frane: \(v2.frame)")
        #expect(v1.frame == .init(x: 100, y: 100, width: 200, height: 800))
        #expect(v2.frame == .init(x: 14, y: 10, width: 175, height: 700))
    }

}

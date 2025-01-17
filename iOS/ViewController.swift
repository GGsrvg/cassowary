//
//  ViewController.swift
//  iOS
//
//  Created by GGsrvg on 12/25/24.
//

import UIKit
import cassowary

class ViewController: UIViewController {

    @IBOutlet var redView: UIView!
    @IBOutlet var yellowView: UIView!
    @IBOutlet var greenView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        redView.accessibilityIdentifier = "x1"
        yellowView.accessibilityIdentifier = "x2"
        greenView.accessibilityIdentifier = "x3"
        
        redView.layer.cornerRadius = 8
        yellowView.layer.cornerRadius = 8
        greenView.layer.cornerRadius = 8
    }

    var step = -1
    @IBAction func update(_ sender: Any) {
        UIView.animate(
            withDuration: 0.2,
            animations: {
                self.step += 1
                
                let numberSetup = self.step % self.setups.count
                self.setups[numberSetup](self)()
            })
    }
    
    let setups: [(ViewController) -> () -> ()] = [
        setup1,
        setup2,
        setup3,
        setup4
    ]

    private func setup1() {
        let v1 = redView!
        let v2 = yellowView!
        greenView.removeFromSuperview()

        v1.removeFromSuperview()

        let manager = ConstraintManager(
            constraints: [
                .init(
                    from: v2.leftAttribute, is: .equal, to: v1.leftAttribute,
                    constant: 14),
                .init(
                    from: v1.rightAttribute, is: .equal, to: v2.rightAttribute,
                    constant: 14),
                .init(
                    from: v2.topAttribute, is: .equal, to: v1.topAttribute,
                    constant: 10),
                .init(
                    from: v1.bottomAttribute, is: .equal,
                    to: v2.bottomAttribute, constant: 90),

                .init(from: v1.topAttribute, is: .equal, constant: 100),
                .init(from: v1.leftAttribute, is: .equal, constant: 100),
                .init(from: v1.widthAttribute, is: .equal, constant: 200),
                .init(from: v1.heightAttribute, is: .equal, constant: 400),
            ]
        )
        try! manager.solve(rootView: v1)

        view.addSubview(v1)

        print("V1 frame: \(v1.frame)")
        print("V2 frame: \(v2.frame)")
    }

    private func setup2() {
        let v1 = redView!
        let v2 = yellowView!
        let v3 = greenView!
        v2.addSubview(v3)

        v1.removeFromSuperview()

        let manager = ConstraintManager(
            constraints: [
                .init(
                    from: v3.leftAttribute, is: .equal, to: v1.leftAttribute,
                    constant: 50),
                .init(
                    from: v1.rightAttribute, is: .equal, to: v3.rightAttribute,
                    constant: 50),
                .init(
                    from: v3.topAttribute, is: .equal, to: v1.topAttribute,
                    constant: 50),
                .init(
                    from: v1.bottomAttribute, is: .equal,
                    to: v3.bottomAttribute, constant: 50),

                .init(
                    from: v3.leftAttribute, is: .equal, to: v2.leftAttribute,
                    constant: 20),
                .init(
                    from: v2.rightAttribute, is: .equal, to: v3.rightAttribute,
                    constant: 20),
                .init(
                    from: v3.topAttribute, is: .equal, to: v2.topAttribute,
                    constant: 20),
                .init(
                    from: v2.bottomAttribute, is: .equal,
                    to: v3.bottomAttribute, constant: 20),

                .init(from: v1.topAttribute, is: .equal, constant: 100),
                .init(from: v1.leftAttribute, is: .equal, constant: 100),
                .init(from: v1.widthAttribute, is: .equal, constant: 200),
                .init(from: v1.heightAttribute, is: .equal, constant: 200),
            ]
        )
        try! manager.solve(rootView: v1)

        view.addSubview(v1)

        print("V1 frame: \(v1.frame)")
        print("V2 frame: \(v2.frame)")
    }

    private func setup3() {
        let v1 = redView!
        let v2 = yellowView!
        let v3 = greenView!
        v3.removeFromSuperview()

        v1.removeFromSuperview()

        let manager = ConstraintManager(
            constraints: [
                .init(
                    from: v2.centerXAttribute,
                    is: .equal,
                    to: v1.centerXAttribute,
                    constant: 0
                ),
                .init(
                    from: v2.centerYAttribute,
                    is: .equal,
                    to: v1.centerYAttribute,
                    constant: 0
                ),
                .init(from: v2.widthAttribute, is: .equal, constant: 50),
                .init(from: v2.heightAttribute, is: .equal, constant: 50),

                .init(from: v1.topAttribute, is: .equal, constant: 100),
                .init(from: v1.leftAttribute, is: .equal, constant: 100),
                .init(from: v1.widthAttribute, is: .equal, constant: 200),
                .init(from: v1.heightAttribute, is: .equal, constant: 200),
            ]
        )
        try! manager.solve(rootView: v1)

        view.addSubview(v1)

        print("V1 frame: \(v1.frame)")
        print("V2 frame: \(v2.frame)")
    }
    
    private func setup4() {
        let v1 = redView!
        let v2 = yellowView!
        greenView.removeFromSuperview()

        v1.removeFromSuperview()

        let manager = ConstraintManager(
            constraints: [
                .init(
                    from: v2.leftAttribute,
                    is: .equal,
                    to: v1.leftAttribute,
                    constant: 14
                ),
                .init(
                    from: v1.rightAttribute,
                    is: .equal,
                    to: v2.rightAttribute,
                    constant: 14
                ),
                .init(
                    from: v2.topAttribute,
                    is: .equal,
                    to: v1.topAttribute,
                    constant: 10,
                    priority: .high
                ),
                .init(
                    from: v2.topAttribute,
                    is: .equal,
                    to: v1.topAttribute,
                    constant: 40,
                    priority: .low
                ),
                .init(
                    from: v1.bottomAttribute,
                    is: .equal,
                    to: v2.bottomAttribute,
                    constant: 90
                ),

                .init(from: v1.topAttribute, is: .equal, constant: 100),
                .init(from: v1.leftAttribute, is: .equal, constant: 100),
                .init(from: v1.widthAttribute, is: .equal, constant: 200),
                .init(from: v1.heightAttribute, is: .equal, constant: 400),
            ]
        )
        try! manager.solve(rootView: v1)

        view.addSubview(v1)

        print("V1 frame: \(v1.frame)")
        print("V2 frame: \(v2.frame)")
    }
}

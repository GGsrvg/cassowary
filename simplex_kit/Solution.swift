//
//  Solution.swift
//  simplex_kit
//
//  Created by GGsrvg on 11/27/24.
//

import Foundation

public struct Solution: Hashable {
    public let objective: Double
    public let constraints: [Variable: Double]
    
    public init(objective: Double, constraints: [Variable : Double]) {
        self.objective = objective
        self.constraints = constraints
    }
}

extension Solution: CustomStringConvertible {
    public var description: String {
        "\(objective)\n\(constraints.sorted(by: { $0.key < $1.key }))"
    }
}

extension Solution: CustomDebugStringConvertible {
    public var debugDescription: String {
        description
    }
}

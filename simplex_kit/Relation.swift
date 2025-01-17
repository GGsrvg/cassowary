//
//  Relation.swift
//  simplex
//
//  Created by GGsrvg on 10/25/24.
//

import Foundation

public enum Relation: Hashable {
    case equal
    case lessOrEqual
    case greaterOrEqual
}

extension Relation: CustomStringConvertible {
    public var description: String {
        switch self {
        case .equal:
            "="
        case .lessOrEqual:
            "<="
        case .greaterOrEqual:
            ">="
        }
    }
}

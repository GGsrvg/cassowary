//
//  ViewAttribute.swift
//  cassowary
//
//  Created by GGsrvg on 12/23/24.
//

import simplex_kit

public struct ViewAttribute: Hashable {
    let view: View
    let attribute: Attribute

    public init(view: View, attribute: Attribute) {
        self.view = view
        self.attribute = attribute
    }
    
    var viewName: String {
        var viewName = view.accessibilityIdentifier ?? "view_\(view.hashValue)"
        if viewName.isEmpty {
            viewName = "view_\(view.hashValue)"
        }
        return viewName
    }
    
    var variable: Variable {
        return switch attribute {
        case .left: Variable(tag: "\(viewName)_minX")
        case .right: Variable(tag: "\(viewName)_maxX")
        case .top: Variable(tag: "\(viewName)_minY")
        case .bottom: Variable(tag: "\(viewName)_maxY")
        case .width: Variable(tag: "\(viewName)_maxX")
        case .height: Variable(tag: "\(viewName)_maxY")
        case .centerX: Variable(tag: "\(viewName)_minX")
        case .centerY: Variable(tag: "\(viewName)_minY")
        }
    }
    
    var altVariable: Variable {
        return switch attribute {
        case .left: Variable(tag: "\(viewName)_maxX")
        case .right: Variable(tag: "\(viewName)_minX")
        case .top: Variable(tag: "\(viewName)_maxY")
        case .bottom: Variable(tag: "\(viewName)_minY")
        case .width: Variable(tag: "\(viewName)_minX")
        case .height: Variable(tag: "\(viewName)_minY")
        case .centerX: Variable(tag: "\(viewName)_maxX")
        case .centerY: Variable(tag: "\(viewName)_maxY")
        }
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(view)
    }
}

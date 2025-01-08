//
//  ExtView.swift
//  cassowary
//
//  Created by GGsrvg on 12/23/24.
//

#if os(iOS)
@_exported import UIKit
public typealias View = UIView
#else
@_exported import AppKit
public typealias View = NSView
public extension NSView {
    var accessibilityIdentifier: String? {
        get { accessibilityIdentifier() }
        set { setAccessibilityIdentifier(newValue) }
    }
}

#endif

public extension View {
    var leftAttribute: ViewAttribute {
        ViewAttribute(view: self, attribute: .left)
    }
    
    var rightAttribute: ViewAttribute {
        ViewAttribute(view: self, attribute: .right)
    }
    
    var topAttribute: ViewAttribute {
        ViewAttribute(view: self, attribute: .top)
    }
    
    var bottomAttribute: ViewAttribute {
        ViewAttribute(view: self, attribute: .bottom)
    }

    var widthAttribute: ViewAttribute {
        ViewAttribute(view: self, attribute: .width)
    }
    
    var heightAttribute: ViewAttribute {
        ViewAttribute(view: self, attribute: .height)
    }
    
    var centerXAttribute: ViewAttribute {
        ViewAttribute(view: self, attribute: .centerX)
    }
    
    var centerYAttribute: ViewAttribute {
        ViewAttribute(view: self, attribute: .centerY)
    }
}

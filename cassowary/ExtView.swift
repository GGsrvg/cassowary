//
//  ExtView.swift
//  cassowary
//
//  Created by GGsrvg on 12/23/24.
//

#if os(iOS) || os(tvOS) || targetEnvironment(macCatalyst)
import UIKit
public typealias View = UIView
#elseif os(macOS)
import AppKit
public typealias View = NSView
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

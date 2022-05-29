//
//  Layout.swift
//  veteranoPizzaIntegration
//
//  Created by User on 28.01.2022.
//

import Foundation
import UIKit

public protocol Layout {
    /// Manage UIView's layout
    ///
    /// - Parameter manager: manage constraints of your view
    func layout(with manager: (LayoutManager)->Void)
}

public protocol LayoutSizeable {
    /// Constraint sizes for view
    /// - Note: view will be constrained with fixed sizes and automaticaly be activated constraints
    /// - Parameter sizes: choose width or height, or both, with sizes you need
    /// - Returns: array of created constraints(in appropriate order)
    func size(_ sizes: LayoutSize...) -> [NSLayoutConstraint]
}

public protocol EdgeConstrainable {
    /// Set appropriate constraints to view into targetView
    /// - Note: view will be constrained with fixed offset and automaticaly be activated constraints
    /// - Parameters:
    ///   - targetView: to which you want to attach
    ///   - edges: mutual edge point for view and targetView
    /// - Returns: array of created constraints(in appropriate order)
    func constraint(to targetView: UIView, by edges: LayoutEdgePoint...) -> [NSLayoutConstraint]
}

public protocol LayoutAnchor {
    func constraint(equalTo anchor: Self,
                    constant: CGFloat) -> NSLayoutConstraint
    func constraint(greaterThanOrEqualTo anchor: Self,
                    constant: CGFloat) -> NSLayoutConstraint
    func constraint(lessThanOrEqualTo anchor: Self,
                    constant: CGFloat) -> NSLayoutConstraint
}

extension NSLayoutAnchor: LayoutAnchor { }


// MARK: - Layout
extension UIView: Layout {
    public func layout(with manager: (LayoutManager) -> Void) {
        allowAutoLayout()
        manager(LayoutManager(for: self))
    }
}

// MARK: -
public class LayoutManager: LayoutSizeable, EdgeConstrainable {
    
    // MARK: - Properties
    private let view: UIView
    
    // MARK: - Anchors
    // XAxis
    public lazy var trailing = Anchor(with: view.trailingAnchor)
    public lazy var leading = Anchor(with: view.leadingAnchor)
    
    // YAxis
    public lazy var top = Anchor(with: view.topAnchor)
    public lazy var bottom = Anchor(with: view.bottomAnchor)
    
    // Center
    public lazy var centerX = Anchor(with: view.centerXAnchor)
    public lazy var centerY = Anchor(with: view.centerYAnchor)
    
    // MARK: - Constructor
    public init(for view: UIView) {
        self.view = view
    }
    
    // MARK: - Methods
    @discardableResult
    public func size(_ sizes: LayoutSize...) -> [NSLayoutConstraint] {
        return sizes.map { view.constraintSize($0) }
    }
    
    @discardableResult
    public func constraint(to targetView: UIView, by edges: LayoutEdgePoint...) -> [NSLayoutConstraint] {
        return edges.map { view.constraint(to: targetView, by: $0) }
    }
}

// MARK: - Sizes constraint
extension UIView {
    fileprivate func constraintSize(_ size: LayoutSize) -> NSLayoutConstraint {
        return anchor(for: size)
            .constraint(equalToConstant: size.offset)
            .activate()
    }
    
    private func anchor(for layout: LayoutSize) -> NSLayoutDimension {
        switch layout {
        case .height:
            return heightAnchor
        case .width:
            return widthAnchor
        }
    }
}

// MARK: - Edge constraint
extension UIView {
    fileprivate func constraint(to view: UIView, by edge: LayoutEdgePoint) -> NSLayoutConstraint {
        switch edge {
        case .top, .bottom:
            guard let point = edge.verticalPoint else {
                fatalError("Can't convert to VerticalPoint")
            }
            
            return anchor(for: point)
                .constraint(equalTo: view.anchor(for: point), constant: edge.offset)
                .activate()
        case .leading, .trailing:
            guard let edgePoint = edge.horizontalPoint else {
                fatalError("Can't convert to HorizontalPoint")
            }
            
            return anchor(for: edgePoint)
                .constraint(equalTo: view.anchor(for: edgePoint), constant: edge.offset)
                .activate()
        }
    }
    
    public func anchor(for horizontal: HorizontalPoint) -> NSLayoutAnchor<NSLayoutXAxisAnchor> {
        switch horizontal {
        case .leading:
            return leadingAnchor
        case .trailing:
            return trailingAnchor
        case .centerX:
            return centerXAnchor
        }
    }
    
    public func anchor(for vertical: VerticalPoint) -> NSLayoutAnchor<NSLayoutYAxisAnchor> {
        switch vertical {
        case .top:
            return topAnchor
        case .bottom:
            return bottomAnchor
        case .centerY:
            return centerYAnchor
        }
    }
}


import UIKit

protocol Offsetable {
    var offset: CGFloat { get }
}

extension Offsetable {
    public var offset: CGFloat {
        let value = Mirror(reflecting: self).children.first?.value as? CGFloat
        return value ?? 0
    }
}

public enum LayoutSize: Offsetable  {
    case height(CGFloat)
    case width(CGFloat)
}

public enum LayoutEdgePoint: Offsetable {
    case top(CGFloat)
    case bottom(CGFloat)
    
    case leading(CGFloat)
    case trailing(CGFloat)
    
    var verticalPoint: VerticalPoint? {
        switch self {
        case .top:
            return .top(offset)
        case .bottom:
            return .bottom(offset)
        default:
            return nil
        }
    }
    
    var horizontalPoint: HorizontalPoint? {
        switch self {
        case .leading:
            return .leading(offset)
        case .trailing:
            return .trailing(offset)
        default:
            return nil
        }
    }
}

public enum HorizontalPoint: Offsetable {
    case leading(CGFloat)
    case trailing(CGFloat)
    case centerX(CGFloat)
}

public enum VerticalPoint: Offsetable {
    case top(CGFloat)
    case bottom(CGFloat)
    case centerY(CGFloat)
}


public struct Anchor<A: LayoutAnchor> {
    fileprivate let anchor: A
    
    init(with anchor: A) {
        self.anchor = anchor
    }
}

// MARK: - XAxis constraint
extension Anchor where A == NSLayoutXAxisAnchor {
    /// Create new constraint for anchor
    ///
    /// - Parameters:
    ///   - targetView: to which you want to attach
    ///   - anchorPoint: horizontal point at targetView
    @discardableResult
    public func constraint(to targetView: UIView,
                           by anchorPoint: HorizontalPoint,
                           priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        let anch = anchor
            .constraint(equalTo: targetView.anchor(for: anchorPoint),
                        constant: anchorPoint.offset)
        anch.priority = priority
        return anch.activate()
    }
}

// MARK: - YAxis constraint
extension Anchor where A == NSLayoutYAxisAnchor {
    /// Create new constraint for anchor
    ///
    /// - Parameters:
    ///   - targetView: to which you want to attach
    ///   - anchorPoint: vertical point at targetView
    @discardableResult
    public func constraint(to targetView: UIView,
                           by anchorPoint: VerticalPoint,
                           priority: UILayoutPriority = .defaultHigh,
                           anchorSign: Sign = .equal) -> NSLayoutConstraint {
        
        var anch: NSLayoutConstraint!
        
        switch anchorSign {
        case .equal:
            anch = anchor
            .constraint(equalTo: targetView.anchor(for: anchorPoint),
                        constant: anchorPoint.offset)
        case .greaterOrEqual:
            anch = anchor.constraint(greaterThanOrEqualTo: targetView.anchor(for: anchorPoint), constant: anchorPoint.offset)
        case .lessOrEqual:
            anch = anchor.constraint(lessThanOrEqualTo: targetView.anchor(for: anchorPoint), constant: anchorPoint.offset)
        }
        
        anch.priority = priority
        return anch.activate()
    }
}

public extension Anchor {
    enum Sign {
        case equal
        case lessOrEqual
        case greaterOrEqual
    }
}

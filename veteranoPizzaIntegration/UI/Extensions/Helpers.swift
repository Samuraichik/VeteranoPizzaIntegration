//
//  Helpers.swift
//  veteranoPizzaIntegration
//
//  Created by User on 28.01.2022.
//

import Foundation
import UIKit

extension UIView {
    public func allowAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}

extension NSLayoutConstraint {
    public func activate() -> NSLayoutConstraint {
        isActive = true
        return self
    }
    
   public func deactivate()  -> NSLayoutConstraint  {
        isActive = false
        return self
    }
}

extension NSLayoutConstraint {
    func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self.firstItem!, attribute: self.firstAttribute, relatedBy: self.relation, toItem: self.secondItem, attribute: self.secondAttribute, multiplier: multiplier, constant: self.constant)
    }
}

struct Size {
    static let width = UIScreen.main.bounds.width
    static let heigth = UIScreen.main.bounds.height
}

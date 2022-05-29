//
//  ColorPalette.swift
//  RiseMe
//
//  Created by Oleksa-Mykhaylo Boyko on 31.01.2021.
//  Copyright © 2021 RiseMe. All rights reserved.
//

import UIKit

public protocol ColorPalette {
    var background01: UIColor { get }
    var background02: UIColor { get }
    var text01: UIColor { get }
    var actions01: UIColor { get }
    var smallItems01: UIColor { get }
    var smallItems02: UIColor { get }
    var smallItems03: UIColor { get }
}

public extension UIColor {
    struct Gradient {
        var top: UIColor
        var bottom: UIColor
    }
    
    struct Priority {
        var low: UIColor
        var medium: UIColor
        var high: UIColor
        var none: UIColor
    }
}

public var Palette: ColorPalette { return PaletteManager.getCurrentPalette() }

fileprivate class PaletteManager {
    fileprivate static func getCurrentPalette() -> ColorPalette {
        return DefaultPalette()
    }
}

fileprivate class DefaultPalette: ColorPalette {
    var background01: UIColor = .init(hexString: "0F0F0F")
    var background02: UIColor = .init(hexString: "202020")
    var actions01: UIColor = .init(hexString: "2D44FF")
    var text01: UIColor = .init(hexString: "FFFFFF")
    var smallItems01: UIColor = .init(hexString: "F7BBD1")
    var smallItems02: UIColor = .init(hexString: "24DC8F")
    var smallItems03: UIColor = .init(hexString: "FC5723")
}

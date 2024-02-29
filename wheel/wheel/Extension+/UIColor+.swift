//
//  UIColor+.swift
//  wheel
//
//  Created by admin on 29/02/2024.
//

import UIKit

extension UIColor {
    static func randomColor() -> UIColor {
        let red = CGFloat(arc4random_uniform(256)) / 255.0
        let green = CGFloat(arc4random_uniform(256)) / 255.0
        let blue = CGFloat(arc4random_uniform(256)) / 255.0
//        let alpha = CGFloat(arc4random_uniform(256)) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}

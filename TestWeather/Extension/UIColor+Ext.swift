//
//  UIColor+Ext.swift
//  TestWeather
//
//  Created by Mephrine on 2020/06/02.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hex: Int, alpha: Float = 1.0) {
        if (0x000000 ... 0xFFFFFF) ~= hex {
            let red = Float((hex >> 16) & 0xFF)
            let green = Float((hex >> 8) & 0xFF)
            let blue = Float((hex) & 0xFF)

            self.init(red: CGFloat(red / 255.0), green: CGFloat(green / 255.0), blue:CGFloat(blue / 255.0), alpha: CGFloat(alpha))
        } else {
            self.init()
        }
    }
}

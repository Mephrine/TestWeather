//
//  UIApplication+Ext.swift
//  TestWeather
//
//  Created by Mephrine on 2020/05/28.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

extension UIApplication {
    static var applicationWindow: UIWindow {
        return (UIApplication.shared.delegate?.window?.flatMap { $0 })!
    }
}

//
//  NSObject+Ext.swift
//  TestWeather
//
//  Created by Mephrine on 2020/05/28.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

extension NSObject {
    public var className: String {
        return NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!;
    }
    
    /**
     # viewController
     - Author: Mephrine
     - Date: 20.02.07
     - Parameters:
     - fromStoryboard: Storyboard 명
     - identifier: Storyboard내 ViewController id
     - Returns: UIViewController?
     - Note: Storyboard의 ViewController를 생성하여 반환
     */
    public func viewController<T: UIViewController>(storyboard: String = "Main", type: T.Type) -> T? {
        let bundle = Bundle(for: self.classForCoder)
        let sb = UIStoryboard(name: storyboard, bundle: bundle)
        
        let identifier = T.description().components(separatedBy: ".").last ?? ""
        
        return sb.instantiateViewController(withIdentifier: identifier) as? T
    }
}

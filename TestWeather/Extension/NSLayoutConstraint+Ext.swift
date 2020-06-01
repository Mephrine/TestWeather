//
//  NSLayoutConstraint+Ext.swift
//  TestWeather
//
//  Created by Mephrine on 2020/05/28.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    func addIdAndActive(_ id: String) -> NSLayoutConstraint {
        self.identifier = id
        self.isActive = true
        return self
    }
    
    func setPriority(_ value: Float?) {
        guard value != nil else { return }
        self.priority = .init(rawValue: value!)
    }
    
    func reamkeMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        NSLayoutConstraint.deactivate([self])
        let newConstraint = NSLayoutConstraint(item: self.firstItem,
                                              attribute: firstAttribute,
                                              relatedBy: self.relation,
                                              toItem: self.secondItem,
                                              attribute: self.secondAttribute,
                                              multiplier: multiplier,
                                              constant: self.constant)
        // View가 가지고 있는 기본 셋팅값을 사용하겠다는 코드
        newConstraint.priority = self.priority
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier
        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
}

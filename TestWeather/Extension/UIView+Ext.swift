//
//  UIView+Ext.swift
//  TestWeather
//
//  Created by Mephrine on 2020/05/28.
//  Copyright © 2020 Mephrine. All rights reserved.
//
import UIKit

extension UIView {
    enum Symbol {
        case equal
        case grater
        case less
    }
    
    var centerX: CGFloat { return self.center.x }
    var centerY: CGFloat { return self.center.y }
    
    func makeConst(top: NSLayoutYAxisAnchor?, paddingTop: CGFloat = 0, bottom: NSLayoutYAxisAnchor?, paddingBottom: CGFloat = 0, left: NSLayoutXAxisAnchor?, paddingLeft: CGFloat = 0, right: NSLayoutXAxisAnchor?, paddingRight: CGFloat = 0, width: CGFloat, height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        self.makeConstTop(top, paddingTop)
        self.makeConstBottom(bottom, paddingBottom)
        self.makeConstLeft(left, paddingLeft)
        self.makeConstRight(right, paddingRight)
        self.makeConstWidth(width)
        self.makeConstHeight(height)
    }
    
    func makeConstEdgeView(target: UIView? = nil, top: CGFloat = 0, bottom: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0) {
        let targetView = target ?? self.superview
        guard let superView = targetView else { return }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        self.makeConstTop(superView.topAnchor, top)
        self.makeConstBottom(superView.bottomAnchor, bottom)
        self.makeConstLeft(superView.leftAnchor, left)
        self.makeConstRight(superView.rightAnchor, right)
        
    }
    
    func makeConstSuperView(top: CGFloat = 0, bottom: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0) {
        self.makeConstEdgeView(top: top, bottom: bottom, left: left, right: right)
    }
    
    func makeConstAspectSuperView(top: CGFloat = 0, bottom: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0,  widthAspect1: CGFloat = 0, widthAspect2: CGFloat = 0, heightAspect1: CGFloat = 0, heightAspect2: CGFloat = 0) {
        
        self.makeConstEdgeView(top: top, bottom: bottom, left: left, right: right)
        self.makeConstAspectRatioWidth(widthAspect1, widthAspect2)
        self.makeConstAspectRatioHeight(heightAspect1, heightAspect2)
    }
    
    func makeConstCenter(target: UIView? = nil) {
        let targetView = target ?? self.superview
        guard let superView = targetView else { return }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        self.makeConstCenterX(superView.centerXAnchor)
        self.makeConstCenterY(superView.centerYAnchor)
    }
    
    
    func setConst<T>(_ identifier: String, _ anchor: T , _ padding: CGFloat, _ symbol: Symbol, _ priority: Float? = 1000) {
        if let anchorY = anchor as? NSLayoutYAxisAnchor {
            switch symbol {
            case .equal:
                if identifier.lowercased().contains("top") {
                    topAnchor.constraint(equalTo: anchorY, constant: padding).addIdAndActive(identifier).setPriority(priority)
                } else if identifier.lowercased().contains("bottom") {
                    bottomAnchor.constraint(equalTo: anchorY, constant: padding).addIdAndActive(identifier).setPriority(priority)
                } else {
                    centerYAnchor.constraint(equalTo: anchorY, constant: padding).addIdAndActive(identifier).setPriority(priority)
                }
            case .grater:
                if identifier.lowercased().contains("top") {
                    topAnchor.constraint(greaterThanOrEqualTo: anchorY, constant: padding).addIdAndActive(identifier).setPriority(priority)
                    
                } else if identifier.lowercased().contains("bottom") {
                    bottomAnchor.constraint(greaterThanOrEqualTo: anchorY, constant: padding).addIdAndActive(identifier).setPriority(priority)
                }  else {
                    centerYAnchor.constraint(greaterThanOrEqualTo: anchorY, constant: padding).addIdAndActive(identifier).setPriority(priority)
                }
            case .less:
                if identifier.lowercased().contains("top") {
                    topAnchor.constraint(lessThanOrEqualTo: anchorY, constant: padding).addIdAndActive(identifier).setPriority(priority)
                } else if identifier.lowercased().contains("bottom") {
                    bottomAnchor.constraint(lessThanOrEqualTo: anchorY, constant: padding).addIdAndActive(identifier).setPriority(priority)
                }  else {
                    centerYAnchor.constraint(lessThanOrEqualTo: anchorY, constant: padding).addIdAndActive(identifier).setPriority(priority)
                }
            }
        } else if let anchorX = anchor as? NSLayoutXAxisAnchor {
            switch symbol {
            case .equal:
                if identifier.lowercased().contains("left") {
                    leftAnchor.constraint(equalTo: anchorX, constant: padding).addIdAndActive(identifier).setPriority(priority)
                } else if identifier.lowercased().contains("right") {
                    rightAnchor.constraint(equalTo: anchorX, constant: padding).addIdAndActive(identifier).setPriority(priority)
                }  else {
                    centerXAnchor.constraint(equalTo: anchorX, constant: padding).addIdAndActive(identifier).setPriority(priority)
                }
            case .grater:
                if identifier.lowercased().contains("left") {
                    leftAnchor.constraint(greaterThanOrEqualTo: anchorX, constant: padding).addIdAndActive(identifier).setPriority(priority)
                } else if identifier.lowercased().contains("right") {
                    rightAnchor.constraint(equalTo: anchorX, constant: padding).addIdAndActive(identifier).setPriority(priority)
                }  else {
                    centerXAnchor.constraint(greaterThanOrEqualTo: anchorX, constant: padding).addIdAndActive(identifier).setPriority(priority)
                }
            case .less:
                if identifier.lowercased().contains("left") {
                    leftAnchor.constraint(lessThanOrEqualTo: anchorX, constant: padding).addIdAndActive(identifier).setPriority(priority)
                } else if identifier.lowercased().contains("right") {
                    rightAnchor.constraint(equalTo: anchorX, constant: padding).addIdAndActive(identifier).setPriority(priority)
                }  else {
                    centerXAnchor.constraint(lessThanOrEqualTo: anchorX, constant: padding).addIdAndActive(identifier).setPriority(priority)
                }
            }
        } else if let anchorDimession = anchor as? NSLayoutDimension {
            switch symbol {
            case .equal:
                if identifier.lowercased().contains("Aspect") {
                    if identifier.lowercased().contains("width") {
                        widthAnchor.constraint(equalTo: heightAnchor, multiplier: padding) .addIdAndActive(identifier).setPriority(priority)
                    } else {
                        heightAnchor.constraint(equalTo: widthAnchor, multiplier: padding).addIdAndActive(identifier).setPriority(priority)
                    }
                } else {
                    if identifier.lowercased().contains("width") {
                        widthAnchor.constraint(equalToConstant: padding).addIdAndActive(identifier).setPriority(priority)
                    } else {
                        heightAnchor.constraint(equalToConstant: padding).addIdAndActive(identifier).setPriority(priority)
                    }
                }
            case .grater:
                if identifier.lowercased().contains("Aspect") {
                    if identifier.lowercased().contains("width") {
                        widthAnchor.constraint(greaterThanOrEqualTo: heightAnchor, multiplier: padding) .addIdAndActive(identifier).setPriority(priority)
                    } else {
                        heightAnchor.constraint(greaterThanOrEqualTo: widthAnchor, multiplier: padding).addIdAndActive(identifier).setPriority(priority)
                    }
                } else {
                    if identifier.lowercased().contains("width") {
                        widthAnchor.constraint(greaterThanOrEqualTo: anchorDimession, constant: padding).addIdAndActive(identifier).setPriority(priority)
                    } else {
                        heightAnchor.constraint(greaterThanOrEqualTo: anchorDimession, constant: padding).addIdAndActive(identifier).setPriority(priority)
                    }
                }
            case .less:
                if identifier.lowercased().contains("Aspect") {
                    if identifier.lowercased().contains("width") {
                        widthAnchor.constraint(lessThanOrEqualTo: heightAnchor, multiplier: padding) .addIdAndActive(identifier).setPriority(priority)
                    } else {
                        heightAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: padding).addIdAndActive(identifier).setPriority(priority)
                    }
                } else {
                    if identifier.lowercased().contains("width") {
                        widthAnchor.constraint(lessThanOrEqualTo: anchorDimession, constant: padding).addIdAndActive(identifier).setPriority(priority)
                    } else {
                        heightAnchor.constraint(lessThanOrEqualTo: anchorDimession, constant: padding).addIdAndActive(identifier).setPriority(priority)
                    }
                }
            }
        }
    }
    
    func makeConstCenterX(_ centerX: NSLayoutXAxisAnchor?, _ padding: CGFloat = 0, _ symbol: Symbol? = .equal, priority: Float? = nil) {
        if let centerX = centerX {
            setConst("constCenterX", centerX, padding, symbol ?? .equal, priority)
        }
    }
    
    func makeConstCenterY(_ centerY: NSLayoutYAxisAnchor?, _ padding: CGFloat = 0, _ symbol: Symbol? = .equal, priority: Float? = nil) {
        if let centerY = centerY {
            setConst("constCenterY", centerY, padding, symbol ?? .equal, priority)
        }
    }
    
    func makeConstTop(_ top: NSLayoutYAxisAnchor?, _ padding: CGFloat = 0, _ symbol: Symbol? = .equal) {
        if let top = top {
            setConst("constTop", top, padding, symbol ?? .equal)
        }
    }
    
    func remakeConstTop(_ top: NSLayoutYAxisAnchor?, _ padding: CGFloat = 0, _ symbol: Symbol? = .equal) {
        self.constraintWithIdentifier("constTop")?.isActive = false
        self.makeConstTop(top, padding, symbol)
    }
    
    func makeConstBottom(_ bottom: NSLayoutYAxisAnchor?, _ padding: CGFloat = 0, _ symbol: Symbol? = .equal, priority: Float? = nil) {
         if let bottom = bottom {
            setConst("constBottom", bottom, -padding, symbol ?? .equal, priority)
        }
    }
    
    func remakeConstBottom(_ bottom: NSLayoutYAxisAnchor?, _ padding: CGFloat = 0, _ symbol: Symbol? = .equal) {
        self.constraintWithIdentifier("constBottom")?.isActive = false
        self.makeConstBottom(bottom, padding)
    }
    
    func makeConstLeft(_ left: NSLayoutXAxisAnchor?, _ padding: CGFloat = 0, _ symbol: Symbol? = .equal) {
        if let left = left {
            setConst("constLeft", left, padding, symbol ?? .equal)
        }
    }
    
    func remakeConstLeft(_ left: NSLayoutXAxisAnchor?, _ padding: CGFloat = 0, _ symbol: Symbol? = .equal) {
        self.constraintWithIdentifier("constLeft")?.isActive = false
        self.makeConstLeft(left, padding)
    }
    
    func makeConstRight(_ right: NSLayoutXAxisAnchor?, _ padding: CGFloat = 0, _ symbol: Symbol? = .equal) {
        if let right = right {
            setConst("constRight", right, -padding, symbol ?? .equal)
        }
    }
    
    func remakeConstRight(_ right: NSLayoutXAxisAnchor?, _ padding: CGFloat = 0, _ symbol: Symbol? = .equal) {
        self.constraintWithIdentifier("constRight")?.isActive = false
        self.makeConstRight(right, padding)
    }
    
    func makeConstWidth(_ width: CGFloat, _ symbol: Symbol? = .equal) {
        if width != 0 {
            setConst("constWidth", widthAnchor, width, symbol ?? .equal)
        }
    }
    
    func remakeConstWidth(_ width: CGFloat, _ symbol: Symbol? = .equal) {
        self.constraintWithIdentifier("constWidth")?.isActive = false
        self.makeConstWidth(width)
    }
    
    func makeConstHeight(_ height: CGFloat, _ symbol: Symbol? = .equal, priority: Float? = nil) {
        if height != 0 {
            setConst("constHeight", heightAnchor, height, symbol ?? .equal)
        }
    }
    
    func remakeConstHeight(_ height: CGFloat, _ symbol: Symbol? = .equal, priority: Float? = nil) {
        self.constraintWithIdentifier("constHeight")?.isActive = false
        self.makeConstHeight(height, priority: priority)
    }
    
    func makeConstAspectRatioWidth(_ aspect1: CGFloat, _ aspect2: CGFloat, _ symbol: Symbol? = .equal) {
        if aspect1 != 0, aspect2 != 0 {
            setConst("constAspectWidth", widthAnchor, aspect1 / aspect2, symbol ?? .equal)
        }
    }
    
    func remakeConstAspectRatioWidth(_ aspect1: CGFloat, _ aspect2: CGFloat, _ symbol: Symbol? = .equal) {
        self.constraintWithIdentifier("constAspectWidth")?.isActive = false
        self.makeConstAspectRatioWidth(aspect1, aspect2)
    }
    
    func makeConstAspectRatioHeight(_ aspect1: CGFloat, _ aspect2: CGFloat, _ symbol: Symbol? = .equal) {
        if aspect1 != 0, aspect2 != 0 {
            setConst("constAspectHeight", heightAnchor, aspect1 / aspect2, symbol ?? .equal)
        }
    }
    
    func remakeConstAspectRatioHeight(_ aspect1: CGFloat, _ aspect2: CGFloat, _ symbol: Symbol? = .equal) {
        self.constraintWithIdentifier("constAspectHeight")?.isActive = false
        self.makeConstAspectRatioHeight(aspect1, aspect2)
    }
    
    /**
     # constraintWithIdentifier
     - Author: Mephrine
     - Date: 20.05.28
     - Parameters:
         - identifier: 뷰의 identifier
     - Returns: NSLayoutConstraint?
     - Note: 현재 뷰의 적용된 constraint를 identifier값으로 찾아서 반환
    */
    func constraintWithIdentifier(_ identifier: String) -> NSLayoutConstraint? {
        var searchView: UIView? = self
        while searchView != nil {
            for constraint in searchView!.constraints as [NSLayoutConstraint] {
                if constraint.identifier == identifier {
                    return constraint
                }
            }
            searchView = searchView!.superview
        }
        return nil
    }
    
    /**
     # removeConstWithIdentifier
     - Author: Mephrine
     - Date: 20.05.28
     - Parameters:
         - identifier: 뷰의 identifier
     - Returns: NSLayoutConstraint?
     - Note: 현재 뷰의 적용된 constraint를 identifier값으로 찾아서 반환
    */
    func removeConstWithIdentifier(_ identifier: String) {
        var searchView: UIView? = self
        while searchView != nil {
            for constraint in searchView!.constraints as [NSLayoutConstraint] {
                if constraint.identifier == identifier {
                    searchView?.removeConstraint(constraint)
                }
            }
            searchView = searchView!.superview
        }
    }
    
    /**
     # removeAllConstraints
     - Author: Mephrine
     - Date: 20.05.28
     - Parameters:
     - Returns:
     - Note: 뷰의 모든 Constraints 제거
    */
    func removeAllConstraints() {
        self.removeConstraints(self.constraints)
        for view in self.subviews {
            view.removeAllConstraints()
        }
    }
    
    /**
     # removeAllSubviews
     - Author: Mephrine
     - Date: 20.05.28
     - Parameters:
     - Returns:
     - Note: 모든 서브뷰 제거
    */
    func removeAllSubviews() {
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
    }
    
    /**
     # imageView
     - Author: Mephrine
     - Date: 20.05.28
     - Parameters:
         - tag: 뷰의 tag
     - Returns: UIImageView?
     - Note: 뷰의 tag값으로 UIImageView를 반환
    */
    func imageView(_ tag: Int) -> UIImageView? {
        return viewWithTag(tag) as? UIImageView
    }
    
    /**
     # label
     - Author: Mephrine
     - Date: 20.05.28
     - Parameters:
         - tag: 뷰의 tag
     - Returns: UILabel?
     - Note: 뷰의 tag값으로 UILabel을 반환
    */
    func label(_ tag: Int) -> UILabel? {
        return viewWithTag(tag) as? UILabel
    }
    
    /**
     # button
     - Author: Mephrine
     - Date: 20.05.28
     - Parameters:
         - tag: 뷰의 tag
     - Returns: UIButton?
     - Note: 뷰의 tag값으로 UIButton을 반환
    */
    func button(_ tag: Int) -> UIButton? {
        return viewWithTag(tag) as? UIButton
    }
    
    /**
     # textfield
     - Author: Mephrine
     - Date: 20.05.28
     - Parameters:
         - tag: 뷰의 tag
     - Returns: UITextField?
     - Note: 뷰의 tag값으로 UITextField를 반환
    */
    func textfield(_ tag: Int) -> UITextField? {
        return viewWithTag(tag) as? UITextField
    }
    
    var isShown: Bool {
        get {
            return !isHidden
        }
        set {
            isHidden = !newValue
        }
    }
}

//MARK: - IBInspectable
extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}

//
//  BaseVC.swift
//  TestWeather
//
//  Created by Mephrine on 2020/05/27.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

/**
 # (C) BaseVC.swift
 - Author: Mephrine
 - Date: 20.05.28
 - Note: 모든 뷰컨트롤러가 상속받는 부모
*/
class BaseVC: UIViewController {
    // 클래스 이름만 체크하는 용도
    lazy private(set) var classNm: String = {
      return type(of: self).description().components(separatedBy: ".").last ?? ""
    }()
    
    private var scrollViewOriginalContentInsetAdjustmentBehaviorRawValue: Int?
    
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // fix iOS 11 scroll view bug
//        if #available(iOS 11, *) {
//          if let scrollView = self.view.subviews.first as? UIScrollView {
//            self.scrollViewOriginalContentInsetAdjustmentBehaviorRawValue =
//              scrollView.contentInsetAdjustmentBehavior.rawValue
//            scrollView.contentInsetAdjustmentBehavior = .never
//          }
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // fix iOS 11 scroll view bug
//        if #available(iOS 11, *) {
//          if let scrollView = self.view.subviews.first as? UIScrollView,
//            let rawValue = self.scrollViewOriginalContentInsetAdjustmentBehaviorRawValue,
//            let behavior = UIScrollView.ContentInsetAdjustmentBehavior(rawValue: rawValue) {
//            scrollView.contentInsetAdjustmentBehavior = behavior
//          }
//        }
        
        self.resetView()
    }
    
    
    // MARK: Override 용도
    /**
     # initView
     - Author: Mephrine
     - Date: 20.05.28
     - Parameters:
     - Returns:
     - Note: viewDidLoad에서 실행할 내용 정의하는 Override용 함수
    */
    public func initView() {
        
    }
    
    /**
     # resetView
     - Author: Mephrine
     - Date: 20.05.28
     - Parameters:
     - Returns:
     - Note: viewWillAppear에서 실행할 내용 정의하는 Override용 함수
    */
    public func resetView() {
        
    }
    
    
    // MARK: SafeArea
    /**
     # safeAreaTopAnchor
     - Author: Mephrine
     - Date: 20.05.28
     - Parameters:
     - Returns: CGFloat
     - Note: 현재 디바이스의 safeAreaTop pixel값을 리턴하는 함수
    */
    var safeAreaTopAnchor: CGFloat {
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            var topPadding = window?.safeAreaInsets.top
            
            if topPadding == 0 {
                topPadding = self.topLayoutGuide.length
                if topPadding == 0 {
                    topPadding = UIApplication.shared.statusBarFrame.size.height
                }
            }
            
            return topPadding ?? Utils.STATUS_HEIGHT
        } else {
            return Utils.STATUS_HEIGHT
        }
    }
    
    /**
     # safeAreaBottomAnchor
     - Author: Mephrine
     - Date: 20.05.28
     - Parameters:
     - Returns: CGFloat
     - Note: 현재 디바이스의 safeAreaBottom pixel값을 리턴하는 함수
    */
    var safeAreaBottomAnchor: CGFloat {
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            let bottomPadding = window?.safeAreaInsets.bottom
            return bottomPadding!
        } else {
            return bottomLayoutGuide.length
        }
    }
    
}


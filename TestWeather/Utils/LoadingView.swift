//
//  LoadingView.swift
//  TestWeather
//
//  Created by Mephrine on 2020/06/02.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

/**
    # (C) LoadingView
    - Author: Mephrine
    - Date: 20.06.02
    - Note: 로딩 화면 뷰
   */
class LoadingView: UIView {
    
    // 컴포넌트
    static let shared = LoadingView()
//    private var isLoading: Bool = false
    private var loadingCnt: Int = 0
    
    /**
     # show
     - Author: Mephrine
     - Date: 20.06.02
     - Parameters:
     - Returns:
     - Note: 로딩뷰 보이기
    */
    public func show() {
        loadingCnt += 1
        if loadingCnt > 1 {
            return
        }

        let ivLoadingView = UIImageView.init(frame: CGRect.zero)
        ivLoadingView.tag = 999

        ivLoadingView.backgroundColor = .clear
        ivLoadingView.animationImages = LoadingView.shared.animArray()   // 애니메이션 이미지
        ivLoadingView.animationDuration = 1.5
        ivLoadingView.animationRepeatCount = 0    // 0일 경우 무한반복

        self.frame = UIScreen.main.bounds
        self.backgroundColor = UIColor(hex: 0x000000, alpha: 0.5)
        
        DispatchQueue.main.async {
            if let window = UIApplication.shared.keyWindow {
                ivLoadingView.center = window.center
                self.addSubview(ivLoadingView)
                window.addSubview(self)
                
                ivLoadingView.makeConstCenter()

                ivLoadingView.startAnimating()
            }
        }
    }

    /**
     # hide
     - Author: Mephrine
     - Date: 20.06.02
     - Parameters:
     - Returns:
     - Note: 로딩뷰 숨기기
    */
    public func hide(_ completion: @escaping (() -> Void)) {
        loadingCnt -= 1
        if loadingCnt > 0 {
            return
        }
        
        DispatchQueue.main.async {
            if let ivLoadingView = self.viewWithTag(999) as? UIImageView {
                ivLoadingView.stopAnimating()
                ivLoadingView.removeFromSuperview()
                
                self.removeFromSuperview()
                completion()
            }
        }
    }
    
    /**
     # animArray
     - Author: Mephrine
     - Date: 20.06.02
     - Parameters:
     - Returns: [UIImage]
     - Note: 로딩뷰로 보여질 UIImage 배열 반환
    */
    func animArray() -> [UIImage] {
        var animArray: [UIImage] = []
        for i in 0 ..< 30 {
            if let img = UIImage(named: "frame-\(i)") {
                animArray.append(img)
            }
        }
        
        return animArray
    }
}

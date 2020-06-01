//
//  UIImageView+Ext.swift
//  TestWeather
//
//  Created by Mephrine on 2020/05/29.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

extension UIImageView {
    func imageFromURL(strURL: String, contentMode: UIView.ContentMode = .scaleAspectFit, placeHolder: UIImage? = nil) {
        self.contentMode = contentMode
        guard let url = URL(string: strURL) else {
            p("image url error : incorrect url")
            self.image = placeHolder
            return
        }
        
        URLSession.shared.loadImage(url) { image, success in
            DispatchQueue.main.async {
                if let resultImage = image {
                    self.image = resultImage
                } else {
                    self.image = placeHolder
                }
            }
        }
    }
    
    func setBg(_ item: Weather) {
        // 
    }
}

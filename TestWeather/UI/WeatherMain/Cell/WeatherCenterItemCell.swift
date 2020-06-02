//
//  WeatherCenterItemCell.swift
//  TestWeather
//
//  Created by Mephrine on 2020/05/29.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

/**
 # (C) WeatherHeaderView.swift
 - Author: Mephrine
 - Date: 20.05.29
 - Note: 날씨뷰컨트롤러의 UICollectionView 헤더뷰내 HorizontalCollectionView의 Cell
*/
class WeatherCenterItemCell: UICollectionViewCell {
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var ivWeather: UIImageView!
    @IBOutlet weak var lbTemp: UILabel!
    @IBOutlet weak var lbFall: UILabel!
    
    func configuration(item: WeatherCenterModel, index: Int) {
        self.lbTime.text = item.displayTime(index: index)
        self.lbTemp.text = item.temp
        self.ivWeather.imageFromURL(strURL: item.icon, contentMode: UIView.ContentMode.scaleAspectFill)
        
        if item.fallRain == "0mm" {
            lbFall.text = ""
        } else {
            lbFall.text = item.fallRain
        }
        
        if lbFall.text?.isEmpty ?? false {
            if item.fallSnow == "0mm" {
                lbFall.text = ""
            } else {
                lbFall.text = item.fallSnow
            }
        }
        
    }
}



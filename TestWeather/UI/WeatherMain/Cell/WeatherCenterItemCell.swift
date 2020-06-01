//
//  WeatherCenterItemCell.swift
//  TestWeather
//
//  Created by Mephrine on 2020/05/29.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

class WeatherCenterItemCell: UICollectionViewCell {
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var ivWeather: UIImageView!
    @IBOutlet weak var lbTemp: UILabel!
    
    func configuration(item: WeatherCenterModel, index: Int) {
        self.lbTime.text = item.displayTime(index: index)
        self.lbTemp.text = item.temp
        self.ivWeather.imageFromURL(strURL: item.icon, contentMode: UIView.ContentMode.scaleAspectFill)
    }
}



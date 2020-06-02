//
//  WeatherWeekItemCell.swift
//  TestWeather
//
//  Created by Mephrine on 2020/05/29.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

/**
 # (C) WeatherWeekItemCell.swift
 - Author: Mephrine
 - Date: 20.05.29
 - Note: 날씨뷰컨트롤러의 UICollectionView의 week Cell내 UITableView의 Cell
*/
class WeatherWeekItemCell: BaseTableViewCell {
    @IBOutlet weak var lbDay: UILabel!
    @IBOutlet weak var lbHighTemp: UILabel!
    @IBOutlet weak var lbLowTemp: UILabel!
    @IBOutlet weak var ivIcon: UIImageView!
    
    func configuration(item: WeatherWeekModel) {
        self.lbDay.text = item.day
        self.lbHighTemp.text = item.highTemp
        self.lbLowTemp.text = item.lowTemp
        self.ivIcon.imageFromURL(strURL: item.icon, contentMode: UIView.ContentMode.scaleAspectFill)
    }
}


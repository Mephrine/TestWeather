//
//  WeatherCurrentInfoCell.swift
//  TestWeather
//
//  Created by Mephrine on 2020/05/29.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

/**
 # (C) WeatherCurrentInfoCell.swift
 - Author: Mephrine
 - Date: 20.05.29
 - Note: 날씨뷰컨트롤러의 UICollectionView의 currentInfo Cell
*/
class WeatherCurrentInfoCell: BaseCollectionViewCell {
    @IBOutlet weak var lbSunRise: UILabel!      // 일출
    @IBOutlet weak var lbSunSet: UILabel!       // 일몰
    @IBOutlet weak var lbFall: UILabel!   // 비 올 확률
    @IBOutlet weak var lbHumidity: UILabel!     // 습도
    @IBOutlet weak var lbWind: UILabel!         // 바람
    @IBOutlet weak var lbFeels: UILabel!        // 체감
    @IBOutlet weak var lbPressure: UILabel!     // 기압
    @IBOutlet weak var lbVisibility: UILabel!   // 가시거리
    
    func configuration(item: WeatherCurrentInfoModel) {
        self.lbSunRise.text = item.sunrise
        self.lbSunSet.text = item.sunset
        self.lbHumidity.text = item.humidity
        self.lbWind.text = item.wind
        self.lbFeels.text = item.feelsLike
        self.lbPressure.text = item.pressure
        self.lbVisibility.text = item.visibility
        
        if item.fallRain == "0mm" {
            lbFall.text = ""
        } else {
            lbFall.text = item.fallRain
        }
        
        if lbFall.text?.isEmpty ?? false {
            lbFall.text = item.fallSnow
        }
    }
}


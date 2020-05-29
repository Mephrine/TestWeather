//
//  WeatherCurrentInfoCell.swift
//  TestWeather
//
//  Created by Mephrine on 2020/05/29.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

class WeatherCurrentInfoCell: BaseTableViewCell, BaseCellProtocol {
    @IBOutlet weak var lbSunRise: UILabel!      // 일출
    @IBOutlet weak var lbSunSet: UILabel!       // 일몰
    @IBOutlet weak var lbChanceRain: UILabel!   // 비 올 확률
    @IBOutlet weak var lbHumidity: UILabel!     // 습도
    @IBOutlet weak var lbWind: UILabel!         // 바람
    @IBOutlet weak var lbFeels: UILabel!        // 체감
    @IBOutlet weak var lbRainFall: UILabel!     // 강수량
    @IBOutlet weak var lbPressure: UILabel!     // 기압
    @IBOutlet weak var lbVisibility: UILabel!   // 가시거리
    @IBOutlet weak var lbUVIndex: UILabel!      // 자외선 지수
    
    func configuration() {
        
    }
}


//
//  WeatherDescCell.swift
//  TestWeather
//
//  Created by Mephrine on 2020/05/29.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

/**
 # (C) WeatherDescCell.swift
 - Author: Mephrine
 - Date: 20.05.29
 - Note: 날씨뷰컨트롤러의 UICollectionView의 desc Cell
*/
class WeatherDescCell: BaseCollectionViewCell {
    @IBOutlet weak var lbDesc: UILabel!
    
    func configuration(item: WeatherDescModel) {
        self.lbDesc.text = item.desc
    }
}


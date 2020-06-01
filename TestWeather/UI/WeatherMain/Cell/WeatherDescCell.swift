//
//  WeatherDescCell.swift
//  TestWeather
//
//  Created by Mephrine on 2020/05/29.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

class WeatherDescCell: BaseCollectionViewCell {
    @IBOutlet weak var lbDesc: UILabel!
    
    func configuration(item: WeatherDescModel) {
        lbDesc.text = "가나다라가나다라가나다라가나다라가나다라가나다라가나다라가나다라가나다라가나다라가나다라가나다라가나다라"
    }
}


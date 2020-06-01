//
//  WeatherListCell.swift
//  TestWeather
//
//  Created by Mephrine on 2020/05/29.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

class WeatherListCell: UITableViewCell {
    @IBOutlet weak var lbCity: UILabel!
    @IBOutlet weak var lbTemp: UILabel!
    
    func configuration(item: WeatherListModel) {
        lbCity.text = item.city
    }
}

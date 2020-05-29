//
//  WeatherHeaderCell.swift
//  TestWeather
//
//  Created by Mephrine on 2020/05/29.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

class WeatherHeaderCell: BaseTableViewCell, BaseCellProtocol {
    @IBOutlet weak var lbCity: UILabel!
    @IBOutlet weak var lbWeather: UILabel!
    @IBOutlet weak var lbTemp: UILabel!
    
    @IBOutlet weak var lbDay: UILabel!
    @IBOutlet weak var lbHighTemp: UILabel!
    @IBOutlet weak var lbLowTemp: UILabel!
    
    func configuration() {
        
    }
}


//
//  WeatherListCell.swift
//  TestWeather
//
//  Created by Mephrine on 2020/05/29.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

class WeatherListCell: BaseTableViewCell {
    @IBOutlet weak var lbCity: UILabel!
    @IBOutlet weak var constIvFlagH: NSLayoutConstraint!
    
    func configuration(item: WeatherListModel, index: Int) {
        self.lbCity.text = item.city
        if Utils.selectedIndexOfLocation() == index {
            self.constIvFlagH.constant = 18
        } else {
            self.constIvFlagH.constant = 0
        }
    }
}

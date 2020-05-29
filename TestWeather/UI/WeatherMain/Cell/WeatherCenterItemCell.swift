//
//  WeatherCenterItemCell.swift
//  TestWeather
//
//  Created by Mephrine on 2020/05/29.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

class WeatherCenterItemCell: UICollectionViewCell, BaseCellProtocol {
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var ivWeather: UIImageView!
    @IBOutlet weak var lbTemp: UILabel!
    
    func configuration() {
        
    }
}



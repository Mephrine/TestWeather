//
//  WeatherHeaderView.swift
//  TestWeather
//
//  Created by Mephrine on 2020/05/29.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

class WeatherHeaderView: UICollectionReusableView {
    @IBOutlet weak var lbCity: UILabel!
    @IBOutlet weak var lbWeather: UILabel!
    @IBOutlet weak var lbTemp: UILabel!
    @IBOutlet weak var lbDay: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbHighTemp: UILabel!
    @IBOutlet weak var lbLowTemp: UILabel!
    @IBOutlet weak var vCenterView: UIView!
    @IBOutlet weak var cvHorizontalWeather: UICollectionView!
    @IBOutlet weak var constBgH: NSLayoutConstraint!
    
    private let itemCell    = "WeatherCenterItemCell"
    var item: WeatherHeaderModel?
    
    override func awakeFromNib() {
        constBgH.constant = Utils.SCREEN_HEIGHT
        
        self.cvHorizontalWeather.dataSource = self
        self.cvHorizontalWeather.delegate   = self
        self.cvHorizontalWeather.register(UINib(nibName: itemCell, bundle: nil), forCellWithReuseIdentifier: itemCell)
        
        if let flowLayout = cvHorizontalWeather.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.itemSize = CGSize.init(width: 60, height: 100)
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    func configuration(item: WeatherHeaderModel) {
        self.item = item
        self.lbCity.text = item.city
        self.lbWeather.text = item.weather
        self.lbTemp.text = item.temp
        self.lbDay.text = item.day
        self.lbTime.text = item.time
        self.lbHighTemp.text = item.highTemp
        self.lbLowTemp.text = item.lowTemp
        
        self.cvHorizontalWeather.reloadData()
    }
    
    func animScrollFade() {
        //TODO: - vCenterView, lbTemp에 적용 필요.
    }
}


extension WeatherHeaderView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCell, for: indexPath) as? WeatherCenterItemCell {
            cell.configuration()
            return cell
        }
        
        return UICollectionViewCell()
    }
}

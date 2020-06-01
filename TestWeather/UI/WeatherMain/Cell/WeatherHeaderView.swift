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
    @IBOutlet weak var constTopViewTop: NSLayoutConstraint!
    
    private let itemCell    = "WeatherCenterItemCell"
    var item: WeatherHeaderModel?
    var itemList = [Weather]()
    
    override func awakeFromNib() {
        constBgH.constant = Utils.SCREEN_HEIGHT
        constTopViewTop.constant = Utils.SAFE_AREA_TOP
        
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
    
    func configuration(item: WeatherHeaderModel, list: DaysWeather) {
        self.item = item
        self.lbCity.text = item.city
        self.lbWeather.text = item.weather
        self.lbTemp.text = item.temp
        self.lbDay.text = item.day
        self.lbTime.text = item.time
        self.lbHighTemp.text = item.highTemp
        self.lbLowTemp.text = item.lowTemp
        if let weatherList = list.list {
            self.itemList = [Weather]()
            for (index, item) in weatherList.enumerated() {
                if index > 9 {
                    break
                }
                self.itemList.append(item)
            }
        }
        
        self.cvHorizontalWeather.reloadData()
    }
}


extension WeatherHeaderView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.row
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCell, for: indexPath) as? WeatherCenterItemCell {
            
            let cellModel = WeatherCenterModel(itemList[index])
            cell.configuration(item: cellModel, index: index)
            return cell
        }
        
        return UICollectionViewCell()
    }
}

extension WeatherHeaderView: HeaderFlowLayoutScrollDelegate {
    func moveOffsetY(offsetY: CGFloat) {
        if offsetY < 100 {
            self.vCenterView.alpha = 1 - abs(offsetY / 100)
        }
        
        self.lbTemp.alpha = 1 - abs(offsetY / 200)
    }
}

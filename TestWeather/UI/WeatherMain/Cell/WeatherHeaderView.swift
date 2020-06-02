//
//  WeatherHeaderView.swift
//  TestWeather
//
//  Created by Mephrine on 2020/05/29.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

/**
 # (C) WeatherHeaderView.swift
 - Author: Mephrine
 - Date: 20.05.29
 - Note: 날씨뷰컨트롤러의 UICollectionView 헤더뷰
*/
class WeatherHeaderView: UICollectionReusableView {
    @IBOutlet weak var ivBg: UIImageView!
    @IBOutlet weak var ivDim: UIView!
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
    @IBOutlet weak var constTopViewH: NSLayoutConstraint!
    
    
    private let itemCell    = "WeatherCenterItemCell"
    var item: WeatherHeaderModel?
    var itemList = [Weather]()
    
    override func awakeFromNib() {
        self.ivBg.alpha = 0.0
        self.ivDim.alpha = 0.0
        
        constBgH.constant = Utils.SCREEN_HEIGHT
        constTopViewTop.constant = Utils.SAFE_AREA_TOP
        constTopViewH.constant = Utils.SAFE_AREA_TOP + 80
        
        self.cvHorizontalWeather.dataSource = self
        self.cvHorizontalWeather.delegate   = self
        self.cvHorizontalWeather.register(UINib(nibName: itemCell, bundle: nil), forCellWithReuseIdentifier: itemCell)
        self.cvHorizontalWeather.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        if let flowLayout = cvHorizontalWeather.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.itemSize = CGSize.init(width: 60, height: 100)
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.headerAnim(_:)), name: NSNotification.Name(NOTI_HEADER_BG_ANIMATION), object: nil)
    }
    
    func configuration(item: WeatherHeaderModel, list: DaysWeather, bgImageNm: String) {
        self.ivBg.alpha = 0.0
        self.ivDim.alpha = 0.0
        
        self.ivBg.image = UIImage(named: bgImageNm)
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

    @objc func headerAnim(_ noti: Notification) {
        self.ivBg.alpha = 1.0
        self.ivDim.alpha = 1.0
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(NOTI_HEADER_BG_ANIMATION), object: nil)
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
        self.vCenterView.alpha = 1 - abs(offsetY / 100)
        self.lbTemp.alpha = 1 - abs(offsetY / 150)
    }
}

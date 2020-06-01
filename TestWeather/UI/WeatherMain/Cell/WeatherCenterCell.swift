//
//  WeatherCenterCell.swift
//  TestWeather
//
//  Created by Mephrine on 2020/05/29.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

class WeatherCenterCell: BaseTableViewCell {
    @IBOutlet weak var cvHorizontalWeather: UICollectionView!
    
    private let itemCell    = "WeatherCenterItemCell"
    var itemList = [WeatherCenterModel]()
    
    override func awakeFromNib() {
        self.cvHorizontalWeather.dataSource = self
        self.cvHorizontalWeather.delegate   = self
        self.cvHorizontalWeather.register(UINib(nibName: itemCell, bundle: nil), forCellWithReuseIdentifier: itemCell)
        self.cvHorizontalWeather.isScrollEnabled = false
        
        if let flowLayout = cvHorizontalWeather.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.itemSize = CGSize.init(width: 60, height: 100)
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    func configuration(item: [WeatherCenterModel]) {
        self.itemList = item
        self.cvHorizontalWeather.reloadData()
    }
}

extension WeatherCenterCell: UICollectionViewDelegate, UICollectionViewDataSource {
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

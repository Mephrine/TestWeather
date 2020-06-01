//
//  WeatherVC.swift
//  TestWeather
//
//  Created by Mephrine on 2020/05/29.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

class WeatherVC: BaseVC {
    // IBOutlet
    @IBOutlet weak var cvWeather: UICollectionView!
    @IBOutlet weak var ivBg: UIImageView!
    
    // Cell Resuable  Identifier
//    private let headerCell      = "WeatherHeaderCell"
//    private let centerCell      = "WeatherCenterCell"
    private let headerView      = "WeatherHeaderView"
    private let weekCell        = "WeatherWeekCell"
    private let descCell        = "WeatherDescCell"
    private let currentInfoCell = "WeatherCurrentInfoCell"
    
    // variable
    private var weather: Weather?
    
    private var currentLat: Double = 0.0
    private var currentLon: Double = 0.0
    
    //enum
    enum WeatherBG {
        case sunny
        case rain
        case cloud
        case thunder
        case snow
        case evening
        
        var imageNm: String {
            switch self {
            case .sunny:
                return "sunny"
            case .rain:
                return "rain"
            case .cloud:
                return "cloud"
            case .thunder:
                return "thunder"
            case .snow:
                return "snow"
            case .evening:
                return "evening"
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // API
        if let item = Utils.indexOfLocation(index: Utils.selectedIndexOfLocation()) {
            self.requestWeather(item.lat, item.lon)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.requestWeather(_:)), name: NSNotification.Name(NOTI_REQUEST_API), object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(NOTI_REQUEST_API), object: nil)
        super.viewDidDisappear(animated)
    }
    
    override func initView() {
        //tableView configuration
        cvWeather.delegate = self
        cvWeather.dataSource = self
        cvWeather.backgroundColor = .clear
        cvWeather.contentInsetAdjustmentBehavior = .never
        
        
        if let flowLayout = cvWeather.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.minimumInteritemSpacing = 0.0
            flowLayout.minimumLineSpacing      = 0
            flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            flowLayout.estimatedItemSize = CGSize.init(width: cvWeather.frame.width, height: cvWeather.frame.height)
        }
        
        cvWeather.register(UINib(nibName:headerView, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerView)
        
        cvWeather.register(WeatherWeekCell.self, forCellWithReuseIdentifier: weekCell)
        cvWeather.register(UINib(nibName:descCell, bundle: nil), forCellWithReuseIdentifier: descCell)
        cvWeather.register(UINib(nibName:currentInfoCell, bundle: nil), forCellWithReuseIdentifier: currentInfoCell)
    }
    
    //MARK: - e.g.
    
    
    //MARK: - Networking
    func requestWeather(_ lat: Double, _ lon: Double) {
        self.currentLat = lat
        self.currentLon = lon
        
        CallAPI.shared.getCurrentWeather(lat: lat.toDecimal, lon: lon.toDecimal) { [weak self] result in
            switch result {
            case .success(let weather):
                self?.weather = weather
                self?.cvWeather.reloadData()
                break
            case .failure(let error):
                if error != .noData {
                    CommonAlert.showAlert(vc: self, message: error.desc ?? "")
                }
                break
            }
        }
    }
    
    @objc func requestWeather(_ noti: Notification) {
        guard currentLat != 0, currentLon != 0 else { return }
        CallAPI.shared.getCurrentWeather(lat: currentLat.toDecimal, lon: currentLon.toDecimal) { [weak self] result in
            switch result {
            case .success(let weather):
                self?.weather = weather
                
                self?.cvWeather.reloadData()
                break
            case .failure(let error):
                if error != .noData {
                    CommonAlert.showAlert(vc: self, message: error.desc ?? "")
                }
                break
            }
        }
    }
    
    //MARK: - Action
    @IBAction func tapBtnChange(_ sender: Any) {
        if let listVC = viewController(type: WeatherListVC.self) {
            let navi = UINavigationController(rootViewController: listVC)
            listVC.resultsHandler = { [weak self] lat, lon in
                self?.requestWeather(lat, lon)
            }
            navi.setNavigationBarHidden(true, animated: false)
            navi.modalPresentationStyle = .fullScreen
            self.navigationController?.present(navi, animated: true)
        }
    }
}

extension WeatherVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
                case 0:
                    return weekCell(collectionView, cellForRowAt: indexPath)
                case 1:
                    return descCell(collectionView, cellForRowAt: indexPath)
                case 2:
                    return currentInfoCell(collectionView, cellForRowAt: indexPath)
                default:
                    return UICollectionViewCell()
                }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerView, for: indexPath)
        
        if let headerView = header as? WeatherHeaderView, let data = weather {
            headerView.configuration(item: WeatherHeaderModel(data))
        }
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
//
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 450)
    }

}

extension WeatherVC  {
    
    func weekCell(_ collectionView: UICollectionView, cellForRowAt indexPath: IndexPath) -> WeatherWeekCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: weekCell, for: indexPath) as! WeatherWeekCell
        if let model = weather {
            let cellModel = WeatherWeekModel(model)
//            cell.configuration(item: cellModel)
            cell.configuration()
        }
        
        return cell
    }
    
    func descCell(_ collectionView: UICollectionView, cellForRowAt indexPath: IndexPath) -> WeatherDescCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: descCell, for: indexPath) as! WeatherDescCell
        if let model = weather {
            let cellModel = WeatherDescModel(model)
            cell.configuration(item: cellModel)
        }
        
        return cell
    }
    
    func currentInfoCell(_ collectionView: UICollectionView, cellForRowAt indexPath: IndexPath) -> WeatherCurrentInfoCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: currentInfoCell, for: indexPath) as! WeatherCurrentInfoCell
        if let model = weather {
            let cellModel = WeatherCurrentInfoModel(model)
            cell.configuration(item: cellModel)
        }
        
        return cell
    }
    
}

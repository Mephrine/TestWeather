//
//  WeatherVC.swift
//  TestWeather
//
//  Created by Mephrine on 2020/05/29.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

/**
 # (C) WeatherVC.swift
 - Author: Mephrine
 - Date: 20.05.29
 - Note: 날씨정보를 보여주는 뷰컨트롤러
*/
class WeatherVC: BaseVC {
    // IBOutlet
    @IBOutlet weak var cvWeather: UICollectionView!
    @IBOutlet weak var ivFakeBg: UIImageView!
    @IBOutlet weak var ivBg: UIImageView!
    
    // Cell Resuable  Identifier
    private let headerView      = "WeatherHeaderView"
    private let weekCell        = "WeatherWeekCell"
    private let descCell        = "WeatherDescCell"
    private let currentInfoCell = "WeatherCurrentInfoCell"
    
    // variable
    private var weather: Weather?                   // 현재 날씨 데이터
    private var daysWeather: DaysWeather?           // 5Days 날씨 데이터
    
    private var currentLat: Double = 0.0
    private var currentLon: Double = 0.0
    
    //enum
    /**
     # (E) WeatherBG
     - Author: Mephrine
     - Date: 20.05.28
     - Note: 배경 이미지 타입 및 이미지명 모음
    */
    enum WeatherBG {
        case sunny
        case rain
        case cloud
        case thunder
        case snow
        case drizzle
        case atmosphere
        case evening
        
        var imageNm: String {
            switch self {
            case .sunny:
                return "sunny"
            case .rain, .drizzle:
                return "rain"
            case .cloud:
                return "cloud"
            case .atmosphere:
                return "fog"
            case .thunder:
                return "thunder"
            case .snow:
                return "snow"
            case .evening:
                return "evening"
            }
        }
    }
    
    // 시간에 따른 아침 / 저녁 이미지 반환
    var timeBg: String {
        if let item = weather {
            let dt = item.dt ?? 0
            let sunrise = item.sys?.sunrise ?? 0
            let sunset = item.sys?.sunset ?? 0
            
            if sunrise > dt || dt > sunset {
                return WeatherBG.evening.imageNm
            }
        }
        
        return WeatherBG.sunny.imageNm
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Utils.SAFE_AREA_TOP = self.safeAreaTopAnchor
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
        cvWeather.alwaysBounceVertical = false
        cvWeather.bounces = false
        
        if let flowLayout = cvWeather.collectionViewLayout as? HeaderFlowLayout {
            flowLayout.minimumInteritemSpacing = 0.0
            flowLayout.minimumLineSpacing      = 0
            flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            flowLayout.estimatedItemSize = CGSize.init(width: Utils.SCREEN_WIDTH, height: cvWeather.frame.size.height)
            flowLayout.itemSize = CGSize.init(width: Utils.SCREEN_WIDTH, height: cvWeather.frame.size.height)
        }
        
        cvWeather.register(UINib(nibName:headerView, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerView)
        
        cvWeather.register(WeatherWeekCell.self, forCellWithReuseIdentifier: weekCell)
        cvWeather.register(UINib(nibName:descCell, bundle: nil), forCellWithReuseIdentifier: descCell)
        cvWeather.register(UINib(nibName:currentInfoCell, bundle: nil), forCellWithReuseIdentifier: currentInfoCell)
        
        cvWeather.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: self.safeAreaBottomAnchor, right: 0)
    }
    
    //MARK: - e.g.
    /**
     # bgImageNm
     - Author: Mephrine
     - Date: 20.05.29
     - Parameters:
     - Returns: String
     - Note: 배경에 적용할 이미지 이름을 계산해서 반환
    */
    func bgImageNm() -> String {
        let id = weather?.weather?.first?.id ?? 0
        if id >= 100 {
            switch id / 100 {
            case 2:
                return WeatherBG.thunder.imageNm
            case 3:
                return WeatherBG.drizzle.imageNm
            case 5:
                return WeatherBG.rain.imageNm
            case 6:
                return WeatherBG.snow.imageNm
            case 7:
                return WeatherBG.atmosphere.imageNm
            case 8:
                if id == 800 {
                    return self.timeBg
                } else {
                    return WeatherBG.cloud.imageNm
                }
            default:
                return self.timeBg
            }
        }
        return self.timeBg
    }
    
    /**
     # setImageBg
     - Author: Mephrine
     - Date: 20.05.29
     - Parameters:
     - Returns:
     - Note: 배경 이미지 변경에 사용되는 함수.
    */
    func setImageBg() {
        let imageNm = self.bgImageNm()
        self.ivFakeBg.image = UIImage(named: imageNm)
        let fakeBg = self.ivFakeBg.image
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1.0, animations: { [weak self] in
                self?.ivBg.alpha = 0.0
            }) {  [weak self] completion in
                NotificationCenter.default.post(name: NSNotification.Name(NOTI_HEADER_BG_ANIMATION), object: nil)
                self?.ivFakeBg.image = self?.ivBg.image
                self?.ivBg.image = fakeBg
                self?.ivBg.alpha = 1
            }
        }
    }
    
    //MARK: - Networking
    /**
     # requestWeather
     - Author: Mephrine
     - Date: 20.05.29
     - Parameters:
        - lat : 위도
        - lon : 경도
     - Returns:
     - Note: 현재 날씨 및 5Days API를 조회하는 함수.
    */
    func requestWeather(_ lat: Double, _ lon: Double) {
        self.currentLat = lat
        self.currentLon = lon
        
        CallAPI.shared.getCurrentWeather(lat: lat.toDecimal, lon: lon.toDecimal) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let weather):
                self.weather = weather
                
                if let array = Utils.unarchiveWeatherList() {
                    let firstModel = array[Utils.selectedIndexOfLocation()]
                    if firstModel.city.isEmpty || firstModel.timeZoneGMT == 0 {
                        let city = weather.name ?? ""
                        let timeZoneGMT = weather.timezone ?? 0
                        Utils.updateLocation(cityNm: city, timeZoneGMT: timeZoneGMT, latitude: lat, longitude: lon)
                    }
                }
                LoadingView.shared.hide {
                    DispatchQueue.main.async {
                        self.cvWeather.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
                        self.setImageBg()
                        self.cvWeather.reloadData()
                    }
                }
                break
            case .failure(let error):
                LoadingView.shared.hide {
                    DispatchQueue.main.async {
                        if error != .noData {
                            self.cvWeather.reloadData()
                            CommonAlert.showAlert(vc: self, message: error.desc ?? "")
                        }
                    }
                }
                
                break
            }
        }
        
        
        CallAPI.shared.getDaysWeather(lat: lat.toDecimal, lon: lon.toDecimal) { [weak self] result in
            switch result {
            case .success(let daysWeather):
                self?.daysWeather = daysWeather
                LoadingView.shared.hide {
                    DispatchQueue.main.async {
                        self?.cvWeather.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
                        self?.setImageBg()
                        self?.cvWeather.reloadData()
                    }
                }
                break
            case .failure(let error):
                LoadingView.shared.hide {
                    DispatchQueue.main.async {
                        if error != .noData {
                            self?.cvWeather.reloadData()
                            CommonAlert.showAlert(vc: self, message: error.desc ?? "")
                        }
                    }
                }
                break
            }
        }
        
    }
    
    /**
     # requestWeather
     - Author: Mephrine
     - Date: 20.05.29
     - Parameters:
        - noti : Notification
     - Returns:
     - Note: Foreground로 다시 접근 시, API를 다시 조회하여 최신 정보 반영하기 위한 함수
    */
    @objc func requestWeather(_ noti: Notification) {
        guard currentLat != 0, currentLon != 0 else { return }
        self.requestWeather(currentLat, currentLon)
    }
    
    //MARK: - Action
    /**
     # tapBtnChange
     - Author: Mephrine
     - Date: 20.05.29
     - Parameters:
        - sender : UIButton sender
     - Returns:
     - Note: 다른 곳의 날씨를 조회하기 위해 WeatherListVC를 호출하는 함수
    */
    @IBAction func tapBtnChange(_ sender: Any) {
        if let listVC = viewController(type: WeatherListVC.self) {
            let navi = UINavigationController(rootViewController: listVC)
            listVC.resultsHandler = { [weak self] lat, lon in
                self?.requestWeather(lat, lon)
            }
            listVC.bgImageNm = self.bgImageNm()
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
        
        if let headerView = header as? WeatherHeaderView, let data = weather, let list = daysWeather {
            headerView.configuration(item: WeatherHeaderModel(data), list: list, bgImageNm: self.bgImageNm())
            
            // headerView에서 HeaderFlowLayout의 프레임 offsetY값을 사용하기 위해 delegate 설정
            if let flowLayout = collectionView.collectionViewLayout as? HeaderFlowLayout {
                flowLayout.delegate = headerView as HeaderFlowLayoutScrollDelegate
            }
        }
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 450 + self.safeAreaTopAnchor)
    }
    
}

extension WeatherVC  {
    func weekCell(_ collectionView: UICollectionView, cellForRowAt indexPath: IndexPath) -> WeatherWeekCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: weekCell, for: indexPath) as! WeatherWeekCell
        if let model = daysWeather {
            cell.configuration(item: model)
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


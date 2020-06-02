//
//  LocationVC.swift
//  TestWeather
//
//  Created by Mephrine on 2020/05/29.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit
import CoreLocation

/**
 # (C) LocationVC.swift
 - Author: Mephrine
 - Date: 20.05.29
 - Note: 최초 접근 시, 현재 위치정보를 이용해서 API를 조회하기 위한 뷰컨트롤러
*/
class LocationVC: BaseVC {
    private var locationManager = CLLocationManager()
    
    private var latitude: Double = 0.0      // 위도
    private var longitude: Double = 0.0     // 경도
    private var timeZoneGMT = 0             // 타임존 GMT
    private var country = ""                // 국가명
    
    private var isChecking = false          // 중복 방지
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
    }
    
    //MARK: - e.g.
    
    /**
     # checkAuth
     - Author: Mephrine
     - Date: 20.05.29
     - Parameters:
     - Returns:
     - Note: 위치정보 권한 확인
    */
    func checkAuth(){
        let authState = CLLocationManager.authorizationStatus()
        self.isChecking = true
        if authState == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else if authState == .denied || authState == .restricted {
            self.setDefaultsLocation()
        } else {
            LoadingView.shared.show()
            self.locationManager.startUpdatingLocation()
        }
    }
    
    /**
     # moveMain
     - Author: Mephrine
     - Date: 20.05.29
     - Parameters:
     - Returns:
     - Note: 위치 정보를 저장하고 WeatherVC로 이동
    */
    func moveMain() {
        if self.isChecking {
            self.isChecking = false
            Utils.insertLocation(cityNm: self.country, timeZoneGMT: self.timeZoneGMT, latitude: self.latitude, longitude: self.longitude)
            if let weatherVC = viewController(type: WeatherVC.self) {
                DispatchQueue.main.async {
                    self.navigationController?.setViewControllers([weatherVC], animated: true)
                }
            }
        }
    }
    
    /**
     # setDefaultsLocation
     - Author: Mephrine
     - Date: 20.05.29
     - Parameters:
     - Returns:
     - Note: 위치 정보를 동의하지 않은 경우, 기본 값으로 설정.
    */
    func setDefaultsLocation() {
        // 위치 정보를 얻어올 수 없을 경우, 서울로 지정
        self.latitude = 37.57
        self.longitude = 126.98
        self.timeZoneGMT = 9 * 60 * 60
        self.country = "서울"
        
        CommonAlert.showAlert(vc: self, message: STR_LOCATION_DENIED) { [weak self] in
            self?.moveMain()
        }
    }
    
    //MARK: - Action
    /**
     # tapBtnAgree
     - Author: Mephrine
     - Date: 20.05.29
     - Parameters:
        - sender : button sender
     - Returns:
     - Note: 위치 정보 동의하기 버튼 클릭 시 위치 정보 권한 체크를 하는 함수.
    */
    @IBAction func tapBtnAgree(_ sender: Any) {
        self.checkAuth()
    }
}

extension LocationVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == .denied || status == .restricted){
            self.setDefaultsLocation()
        } else {
            LoadingView.shared.show()
            self.locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = manager.location {
            DispatchQueue.global().async {
                CLGeocoder().reverseGeocodeLocation(location) { [weak self] placeMark, error in
                    guard let self = self else { return }
                    LoadingView.shared.hide{
                        if error == nil {
                            if let tzGMT = placeMark?.first?.timeZone?.secondsFromGMT() {
                                self.timeZoneGMT = tzGMT
                            }
                            self.country = placeMark?.first?.locality ?? ""
                        }
                        let coordinate = location.coordinate
                        self.latitude = coordinate.latitude
                        self.longitude = coordinate.longitude
                        self.locationManager.stopUpdatingLocation()
                        self.moveMain()
                    }
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        LoadingView.shared.hide{}
        self.locationManager.stopUpdatingLocation()
        self.setDefaultsLocation()
        p("locationManager fail : \(error.localizedDescription)")
    }
}


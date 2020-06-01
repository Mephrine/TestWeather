//
//  LocationVC.swift
//  TestWeather
//
//  Created by Mephrine on 2020/05/29.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit
import CoreLocation

class LocationVC: BaseVC {
    private var locationManager = CLLocationManager()
    
    private var latitude: Double = 0.0      // 위도
    private var longitude: Double = 0.0     // 경도
    
    private var isChecking = false          // 중복 방지
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
    }
    
    //MARK: - e.g.
    func checkAuth(){
        let authState = CLLocationManager.authorizationStatus()
        self.isChecking = true
        if authState == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else if authState == .denied || authState == .restricted {
            self.setDefaultsLocation()
        } else {
            self.locationManager.startUpdatingLocation()
        }
    }
    
    func moveMain() {
        if self.isChecking {
            self.isChecking = false
            Utils.insertLocation(latitude: latitude, longitude: longitude)
            if let weatherVC = viewController(type: WeatherVC.self) {
                self.navigationController?.setViewControllers([weatherVC], animated: true)
            }
        }
    }
    
    func setDefaultsLocation() {
        // 위치 정보를 얻어올 수 없을 경우, 서울로 지정
        self.latitude = 37.57
        self.longitude = 126.98
        
        self.moveMain()
    }
    
    //MARK: - Action

    @IBAction func tapBtnAgree(_ sender: Any) {
        self.checkAuth()
    }
}

extension LocationVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        p("locationManager : \(status)")
        if(status == .denied){
            self.setDefaultsLocation()
        } else {
            self.locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = manager.location?.coordinate {
            p("location update\nlon : \(coordinate.longitude)\nlat : \(coordinate.latitude)")
            self.latitude = coordinate.latitude
            self.longitude = coordinate.longitude
            self.locationManager.stopUpdatingLocation()
            
            self.moveMain()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            self.locationManager.stopUpdatingLocation()
            self.setDefaultsLocation()
            p("locationManager fail : \(error.localizedDescription)")
    }
}


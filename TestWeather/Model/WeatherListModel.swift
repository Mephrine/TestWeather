//
//  WeatherListModel.swift
//  TestWeather
//
//  Created by Mephrine on 2020/06/01.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import Foundation

/**
 # (C) WeatherListModel.swift
 - Author: Mephrine
 - Date: 20.06.01
 - Note: 추가한 도시를 UserDefault로 저장하기 위한 모델
*/
class WeatherListModel: NSObject, NSSecureCoding {
    static var supportsSecureCoding: Bool {
        return true
    }
    
    var lat: Double
    var lon: Double
    var city: String
    var timeZoneGMT: Int
    
    func encode(with coder: NSCoder) {
        coder.encode(self.lat, forKey: "lat")
        coder.encode(self.lon, forKey: "lon")
        coder.encode(self.city, forKey: "city")
        coder.encode(self.timeZoneGMT, forKey: "timeZoneGMT")
    }
    
    required init?(coder: NSCoder) {
        self.lat = coder.decodeDouble(forKey: "lat")
        self.lon = coder.decodeDouble(forKey: "lon")
        self.city = coder.decodeObject(forKey: "city") as! String
        self.timeZoneGMT = Int(coder.decodeInt32(forKey: "timeZoneGMT"))
    }
    
    init(lat: Double, lon: Double, city: String, timeZoneGMT: Int) {
        self.lat = lat
        self.lon = lon
        self.city = city
        self.timeZoneGMT = timeZoneGMT
    }
}

//
//  WeatherListModel.swift
//  TestWeather
//
//  Created by Mephrine on 2020/06/01.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import Foundation

class WeatherListModel: NSObject, NSSecureCoding {
    static var supportsSecureCoding: Bool {
        return true
    }
    
    var lat: Double
    var lon: Double
    var city: String
    
    func encode(with coder: NSCoder) {
        coder.encode(self.lat, forKey: "lat")
        coder.encode(self.lon, forKey: "lon")
        coder.encode(self.city, forKey: "city")
    }
    
    required init?(coder: NSCoder) {
        self.lat = coder.decodeDouble(forKey: "lat")
        self.lon = coder.decodeDouble(forKey: "lon")
        self.city = coder.decodeObject(forKey: "city") as! String
    }
    
    init(lat: Double, lon: Double, city: String) {
        self.lat = lat
        self.lon = lon
        self.city = city
    }
}

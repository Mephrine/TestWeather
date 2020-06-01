//
//  WeatherHeaderModel.swift
//  TestWeather
//
//  Created by Mephrine on 2020/05/30.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import Foundation

struct WeatherHeaderModel {
    private var item: Weather
    
    init(_ weather: Weather) {
        self.item = weather
    }
    
    var city: String {
        return item.name ?? ""
    }
    
    var weather: String {
        return item.weather?.first?.description ?? ""
    }
    
    var temp: String {
        return (item.main?.temp ?? 0.0).toCelsiusIncldeDegree
    }
    
    var time: String {
        let dt = item.dt ?? 0
        let sunrise = item.sys?.sunrise ?? 0
        let sunset = item.sys?.sunset ?? 0
        
        p("dt : \(dt) | \(sunrise) | \(sunset)")
        // 오늘 | 야간 2개로만 설정.
        if sunrise > dt || dt > sunset {
            return "야간"
        }
        
        return "오늘"
    }
    
    var day: String {
        return item.dt?.millsToDate().weekDayStr() ?? ""
    }
    
    var highTemp: String {
        return (item.main?.tempMax ?? 0.0).toCelsius
    }
    
    var lowTemp: String {
        return (item.main?.tempMin ?? 0.0).toCelsius
    }
}

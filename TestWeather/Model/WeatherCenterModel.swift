//
//  WeatherCenterModel.swift
//  TestWeather
//
//  Created by Mephrine on 2020/05/30.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import Foundation

struct WeatherCenterModel {
    private var item: Weather
    
    init(_ weather: Weather) {
        self.item = weather
    }
    
    var temp: String {
        return (item.main?.temp ?? 0.0).toCelsiusIncldeDegree
    }
    
    var icon: String {
        return item.weather?.first?.icon ?? ""
    }
    
    var day: String {
        return item.dt?.millsToDate().formatted("a h'시'") ?? ""
    }
    
    func displayTime(index: Int) -> String {
        if index == 0 {
            return "지금"
        } else {
            return self.day
        }
    }
}

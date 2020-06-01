//
//  WeatherWeekModel.swift
//  TestWeather
//
//  Created by Mephrine on 2020/05/30.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import Foundation

struct WeatherWeekModel {
    private var item: Weather
    
    init(_ weather: Weather) {
        self.item = weather
    }
    
    var icon: URL? {
        return item.weather?.first?.icon
    }
    
    var day: String {
        return ""
    }
    
    var highTemp: Double {
        return item.main?.tempMax ?? 0.0
    }
    
    var lowTemp: Double {
        return item.main?.tempMin ?? 0.0
    }
}

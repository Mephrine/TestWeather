//
//  WeatherWeekModel.swift
//  TestWeather
//
//  Created by Mephrine on 2020/05/30.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import Foundation

/**
 # (S) WeatherWeekModel.swift
 - Author: Mephrine
 - Date: 20.05.30
 - Note: WeatherVC내 CollectionView week Cell에서 사용될 데이터 모델
*/
struct WeatherWeekModel {
    private var item: Weather
    
    init(_ weather: Weather) {
        self.item = weather
    }
    
    var icon: String {
        return item.weather?.first?.icon ?? ""
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

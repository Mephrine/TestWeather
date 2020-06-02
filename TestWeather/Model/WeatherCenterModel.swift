//
//  WeatherCenterModel.swift
//  TestWeather
//
//  Created by Mephrine on 2020/05/30.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import Foundation

/**
 # (S) WeatherCenterModel.swift
 - Author: Mephrine
 - Date: 20.05.30
 - Note: WeatherVC내 CollectionView 헤더뷰 하단에서 사용될 데이터 모델
*/
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
    
    var fallRain: String {
        if let fall = item.rain?.hourOne {
            return String(format:"%.1f", fall) + "mm"
        } else if let fall = item.rain?.hourThree {
            return  String(format:"%.1f", fall) + "mm"
        }
        return "0mm"
    }
    
    var fallSnow: String {
        if let fall = item.snow?.hourOne {
            return String(format:"%.1f", fall) + "mm"
        } else if let fall = item.snow?.hourThree {
            return  String(format:"%.1f", fall) + "mm"
        }
        return "0mm"
    }
    
    func displayTime(index: Int) -> String {
        if index == 0 {
            return "지금"
        } else {
            return self.day
        }
    }
    
}

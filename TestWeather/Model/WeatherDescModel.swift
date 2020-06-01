//
//  WeatherDescModel.swift
//  TestWeather
//
//  Created by Mephrine on 2020/05/30.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import Foundation

struct WeatherDescModel {
    private var item: Weather
    
    init(_ weather: Weather) {
        self.item = weather
    }
    
    private var weather: String {
        return item.weather?.first?.description ?? ""
    }
    
    private var temp: String {
        return (item.main?.temp ?? 0.0).toCelsiusIncldeDegree
    }
    
    private var highTemp: String {
        return (item.main?.tempMax ?? 0.0).toCelsiusIncldeDegree
    }
    
    var desc: String {
        return "오늘: 현재 날씨 \(weather), 기온은 \(temp)이며 최고 기온은 \(highTemp)입니다."
    }
}

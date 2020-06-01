//
//  WeatherCurrentInfoModel.swift
//  TestWeather
//
//  Created by Mephrine on 2020/05/30.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import Foundation

struct WeatherCurrentInfoModel {
    private var item: Weather
    
    init(_ weather: Weather) {
        self.item = weather
    }
    
    var sunrise: String {
        return item.sys?.sunrise?.millsToDate().formatted("a h:mm") ?? ""
    }
    
    var sunset: String {
        return item.sys?.sunset?.millsToDate().formatted("a h:mm") ?? ""
    }
    
    var chanceRain: String {
        if let chance = item.rain?.hourOne {
            return "\(chance)cm"
        } else if let chance = item.rain?.hourThree {
            return "\(chance)cm"
        }
        return "0cm"
    }
    
    var humidity: String {
        return "\(item.main?.humidity ?? 0)%"
    }
    
    var wind: String {
        let speed = item.wind?.speed ?? 0
        if let degree = item.wind?.deg {
            if (degree >= 0 && degree < 11.25) || (degree >= 348.75) {
                return "북 \(speed)m/s"
            } else if (degree >= 11.25 && degree < 33.75) {
                return "북북동 \(speed)m/s"
            } else if (degree >= 33.75 && degree < 56.25) {
                return "북동 \(speed)m/s"
            } else if (degree >= 56.25 && degree < 78.75) {
                return "동북동 \(speed)m/s"
            } else if (degree >= 78.75 && degree < 101.25) {
                return "동 \(speed)m/s"
            } else if (degree >= 101.25 && degree < 123.75) {
                return "동남동 \(speed)m/s"
            } else if (degree >= 123.75 && degree < 146.25) {
                return "남동 \(speed)m/s"
            } else if (degree >= 146.25 && degree < 168.75) {
                return "남남동 \(speed)m/s"
            } else if (degree >= 168.75 && degree < 191.25) {
                return "남 \(speed)m/s"
            } else if (degree >= 191.25 && degree < 213.75) {
                return "남남서 \(speed)m/s"
            } else if (degree >= 213.75 && degree < 236.25) {
                return "남서 \(speed)m/s"
            } else if (degree >= 236.25 && degree < 258.75) {
                return "서남서 \(speed)m/s"
            } else if (degree >= 258.75 && degree < 281.25) {
                return "서 \(speed)m/s"
            } else if (degree >= 281.25 && degree < 303.75) {
                return "서북서 \(speed)m/s"
            } else if (degree >= 303.75 && degree < 326.25) {
                return "북서 \(speed)m/s"
            } else if (degree >= 326.25 && degree < 348.75) {
                return "북북서 \(speed)m/s"
            }
        }
        
        return "\(speed)m/s"
    }
    
    var feelsLike: String {
        return (item.main?.feelsLike ?? 0.0).toCelsiusIncldeDegree
    }
    
    var pressure: String {
        return (item.main?.pressure ?? 0).toPressure
    }
    
    var visibility: String {
        return (item.visibility ?? 0).toKilioMeters
    }
}


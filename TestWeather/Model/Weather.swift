//
//  Weather.swift
//  TestWeather
//
//  Created by Mephrine on 2020/05/28.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import Foundation

struct Weather: Codable {
    let main: WeatherMain?
    let weather: [WeatherSub]?
    let visibility: Double?
    let rain: Fall?
    let snow: Fall?
    let wind: Wind?
    let clouds: Clouds?
    let dt: Double?
    let sys: WeatherSys?
    let name: String?
}

struct WeatherMain: Codable {
    let humidity: Double
    let pressure: Double
    let feelsLike: Double
    let temp: Double
    let tempMax: Double
    let tempMin: Double
    
    enum CodingKeys: String, CodingKey {
        case humidity = "humidity"
        case pressure = "pressure"
        case feelsLike = "feels_like"
        case temp = "temp"
        case tempMax = "temp_max"
        case tempMin = "temp_min"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.humidity = (try? values.decode(Double.self, forKey: .humidity)) ?? 0.0
        self.pressure = (try? values.decode(Double.self, forKey: .pressure)) ?? 0.0
        self.feelsLike = (try? values.decode(Double.self, forKey: .feelsLike)) ?? 0.0
        self.temp = (try? values.decode(Double.self, forKey: .temp)) ?? 0.0
        self.tempMax = (try? values.decode(Double.self, forKey: .tempMax)) ?? 0.0
        self.tempMin = (try? values.decode(Double.self, forKey: .tempMin)) ?? 0.0
    }
}

struct WeatherSub: Codable {
    let main: String?
    let description: String?
    let icon: URL?
    
    enum CodingKeys: String, CodingKey {
        case main = "main"
        case description = "description"
        case icon = "icon"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.main = (try? values.decode(String.self, forKey: .main)) ?? ""
        self.description = (try? values.decode(String.self, forKey: .description)) ?? ""
        let strIcon = (try? values.decode(String.self, forKey: .icon)) ?? ""
        self.icon = URL(string: "\(ICON_DOMAIN)\(strIcon).png")
    }
}

struct Fall: Codable {
    let hourOne: Double?
    let hourThree: Double?
    
    enum CodingKeys: String, CodingKey {
        case hourOne = "1h"
        case hourThree = "3h"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.hourOne = (try? values.decode(Double.self, forKey: .hourOne)) ?? 0.0
        self.hourThree = (try? values.decode(Double.self, forKey: .hourThree)) ?? 0.0
    }
}

struct Wind: Codable {
    let speed: Double?
    let deg: Double?
}

struct Clouds: Codable {
    let all: Double?
    
}

struct WeatherSys: Codable {
    let country: String?
    let sunrise: Double?
    let sunset: Double?
}

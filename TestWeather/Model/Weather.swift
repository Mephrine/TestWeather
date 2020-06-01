//
//  Weather.swift
//  TestWeather
//
//  Created by Mephrine on 2020/05/28.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import Foundation

struct DaysWeather: Codable {
    let list: [Weather]?
}

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
    let city: City?
    let dtTxt: String
    
    enum CodingKeys: String, CodingKey {
        case main = "main"
        case weather = "weather"
        case visibility = "visibility"
        case rain = "rain"
        case snow = "snow"
        case wind = "wind"
        case clouds = "clouds"
        case dt = "dt"
        case sys = "sys"
        case name = "name"
        case city = "city"
        case dtTxt = "dt_txt"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.main = (try? values.decode(WeatherMain.self, forKey: .main))
        self.weather = (try? values.decode([WeatherSub].self, forKey: .weather))
        self.visibility = (try? values.decode(Double.self, forKey: .visibility))
        self.rain = (try? values.decode(Fall.self, forKey: .rain))
        self.snow = (try? values.decode(Fall.self, forKey: .snow))
        self.wind = (try? values.decode(Wind.self, forKey: .wind))
        self.clouds = (try? values.decode(Clouds.self, forKey: .clouds))
        self.dt = (try? values.decode(Double.self, forKey: .dt))
        self.sys = (try? values.decode(WeatherSys.self, forKey: .sys))
        self.name = (try? values.decode(String.self, forKey: .name))
        self.city = (try? values.decode(City.self, forKey: .city))
        self.dtTxt = (try? values.decode(String.self, forKey: .dtTxt)) ?? ""
    }
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
    let icon: String?
    
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
        self.icon = "\(ICON_DOMAIN)\(strIcon).png"
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

struct City: Codable {
    let country: String?
    let sunrise: Double?
    let sunset: Double?
}

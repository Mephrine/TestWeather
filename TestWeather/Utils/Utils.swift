//
//  Utils.swift
//  TestWeather
//
//  Created by Mephrine on 2020/05/27.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

public func p(_ items: Any...) {
    #if DEBUG
    let output = items.map { "***\($0)***" }.joined(separator: " | ")
    Swift.print(output, terminator: "\n")
    #endif
}

public let Defaults = UserDefaults.standard

class Utils: NSObject {
    public static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    public static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    public static let STATUS_HEIGHT = UIApplication.shared.statusBarFrame.size.height
    
    static func insertLocation(cityNm: String? = "", latitude: Double, longitude: Double) {
        var array = Defaults.array(forKey: UD_REGI_LOCATION_LIST)
        let model = WeatherListModel(lat: latitude, lon: longitude, city: cityNm ?? "")
        if array == nil {
            array = [WeatherListModel]()
        }
        
        array?.append(model)
        Defaults.setValue(array, forKey: UD_REGI_LOCATION_LIST)
    }
    
    static func updateLocation(cityNm: String? = "", latitude: Double, longitude: Double) {
        
        var array = Defaults.array(forKey: UD_REGI_LOCATION_LIST) as? [WeatherListModel]
        
        if let arrLocation = array {
            for (index, model) in arrLocation.enumerated() {
                if model.lat == latitude && model.lon == longitude {
                    let newModel = WeatherListModel(lat: latitude, lon: longitude, city: cityNm ?? "")
                    array?.insert(newModel, at: index)
                    Defaults.setValue(array, forKey: UD_REGI_LOCATION_LIST)
                    return
                }
                
            }
        }
    }
    
    static func indexOfLocation(index: Int) -> WeatherListModel? {
        let array = Defaults.array(forKey: UD_REGI_LOCATION_LIST) as? [WeatherListModel]
        return array?[index]
    }
    
    static func removeLocation(index: Int) {
        var array = Defaults.array(forKey: UD_REGI_LOCATION_LIST) ?? [[String: Any]]()
        if index < array.count {
            array.remove(at: index)
        }
        
        Defaults.setValue(array, forKey: UD_REGI_LOCATION_LIST)
    }
    
    static func selectedIndexOfLocation() -> Int {
        return Defaults.integer(forKey: UD_CURRENT_LOCATION_INDEX)
    }
    
    static func setSelectedIndexOfLocation(index: Int) {
        Defaults.set(index, forKey: UD_CURRENT_LOCATION_INDEX)
    }
}

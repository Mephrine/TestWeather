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
    
    static func addLocation(cityNm: String? = "", latitude: Double, longitude: Double) {
        var array = Defaults.array(forKey: UD_REGI_LOCATION_LIST)
        if array == nil {
            array = [[String: Any]]()
        }
        
        array?.append(["city": cityNm ?? "", "lat": latitude, "lon": longitude])
        Defaults.setValue(array, forKey: UD_REGI_LOCATION_LIST)
    }
}

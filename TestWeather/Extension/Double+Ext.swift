//
//  Double+Ext.swift
//  TestWeather
//
//  Created by Mephrine on 2020/05/29.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import Foundation

extension Double {
    // 소숫점 2자리
    var toDecimal: String {   
        return String(format: "%.2f", self)
    }
    
    // 화씨 -> 섭씨로 변경
    var toCelsiusIncldeDegree: String {
        var celsius = self
        if celsius > 0 {
            celsius -= 273.15
        }
        return String(format: "%.0f°", celsius)
    }
    
    var toCelsius: String {
        var celsius = self
        if celsius > 0 {
            celsius -= 273.15
        }
        return String(format: "%.0f", celsius)
    }
    
    // 화씨로 사용
    var toFahrenhait: String {
        return String(format: "%.0f°", self)
    }
    
    // 기압
    var toPressure: String {
        return "\(self)hPa"
    }
    
    // 습도
    var toHumidity: String {
        return "\(self)%"
    }
    
    // 킬로미터
    var toKilioMeters: String {
        return String(format: "%.2fkm", self / 1000.0)
    }
    
    func millsToDate() -> Date {
        return Date(timeIntervalSince1970: (self / 1000.0))
    }
}

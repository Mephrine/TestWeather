//
//  Date+Ext.swift
//  TestWeather
//
//  Created by Mephrine on 2020/06/01.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import Foundation

extension Date {
    var calendar: Calendar {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC")!
        return calendar
    }
    
    var calendarAuto: Calendar {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: -9 * 60 * 60)!
        
        return calendar
    }
    
    var dateSymbol: String {
        return self.dateToString(date: self, "a")
    }
    
    var time: String {
        return self.dateToString(date: self, "HH:mm")
    }
    
    
    func correctSecondComponent() -> Date {
        let second = self.calendar.component(.second, from: self)
        let date = (self.calendar as NSCalendar).date(byAdding: NSCalendar.Unit.second, value: -second, to: self, options:.matchStrictly)!
        return date
    }
    
    func isFuture() -> Bool {
        let seconds = self.correctSecondComponent().timeIntervalSince1970
        let now = Date().correctSecondComponent().timeIntervalSince1970
        
        return seconds > now
    }
    
    func fromFormat(_ format: String) -> (String) -> Date? {
        let df = DateFormatter()
        df.dateFormat = format
        df.timeZone = TimeZone.init(abbreviation: "UTC")
        return { dateString in
            guard !dateString.isEmpty else { return nil }
            return df.date(from: dateString)
        }
    }
    
    func fromServerFormat() -> (String) -> Date? {
        return fromFormat("yyyy-MM-dd HH:mm:ss")
    }
    
    
    /// 요일 반환
    func weekDayStr() -> String {
        
        let units: Set<Calendar.Component> = [.weekday]
        let comps = self.calendar.dateComponents(units, from: self)
        
        if let value = comps.weekday {
            switch value {
            case 1:
                return "일요일"
            case 2:
                return "월요일"
            case 3:
                return "화요일"
            case 4:
                return "수요일"
            case 5:
                return "목요일"
            case 6:
                return "금요일"
            case 7:
                return "토요일"
            default:
                return "일요일"
            }
        }
        return "일요일"
    }
    
    // 두 날짜간 비교해서 과거/현재/미래 체크.
    func dateCompare(fromDate:Date) -> String {
        var strDateMessage:String = ""
        let result:ComparisonResult = self.compare(fromDate)
        switch result {
        case .orderedAscending:
            strDateMessage = "Future"
            break
        case .orderedDescending:
            strDateMessage = "Past"
            break
        case .orderedSame:
            strDateMessage = "Same"
            break
        default:
            strDateMessage = "Error"
            break
        }
        return strDateMessage
    }
    
    // 3개의 날짜 비교. 내가 원하는 시간이 해당 기간에 포함되는지!
    // 1 : 기간에 포함됨
    // 2 : 기간에 포함안됨 - 날짜가 지났음
    // 3 : 기간에 포함안됨 - 날짜가 시작되지 않음
    //
    func dateCompare(startDate: Date, endDate: Date) -> Int {
        let compare = dateCompare(fromDate: startDate)
        let compare2 = dateCompare(fromDate: endDate)
        
        if compare == "Past" {
            if compare2 == "Future" {
                // 두 날짜 사이에 포함.
                return 1
            }
            else{
                // endDate을 벗어남.
                return 2
            }
        }
            
        else if compare == "Same" {
            //  현재
            return 1
        } else {
            // startDate 이전.
            return 3
        }
    }
    
    func dateToString(date: Date, _ format: String = "yyyy-MM-dd") -> String {
        let df = DateFormatter()
        df.dateFormat = format
        df.timeZone = TimeZone.autoupdatingCurrent
        return df.string(from: date)
    }
    
    func formatted(_ format: String) -> String {
        let df = DateFormatter()
        df.dateFormat = format
        df.timeZone = TimeZone(identifier: "UTC")!
        
        return df.string(from: self)
    }
    
    /// 스트링 변환 : 날짜 포멧
    func toString(_ format:String, am:String? = nil, pm:String? = nil)-> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        dateFormatter.dateFormat = format
        
        if let amSymbol = am {
            dateFormatter.amSymbol = amSymbol
        }
        if let pmSymbol = pm {
            dateFormatter.pmSymbol = pmSymbol
        }
        
        return dateFormatter.string(from: self)
    }
    
    // 날짜 변환 : 날짜 포멧
    func toDateKoreaTime()-> Date {
        
        var today = Date()
        let format = "yyyyMMddHHmmssSSS"
        let date = self.toString(format)
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone(secondsFromGMT: -9 * 60 * 60)
        if let value = formatter.date(from:date) {
            today = value
        }
        
        return today
    }
    
    func toDateUTCTime()-> Date {
        
        var today = Date()
        let format = "yyyyMMddHHmmss"
        let date = self.toString(format)
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone(secondsFromGMT: +9 * 60 * 60)
        if let value = formatter.date(from:date) {
            today = value
        }
        
        return today
    }
    
    func currentMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}

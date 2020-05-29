//
//  Dictionary+Ext.swift
//  TestWeather
//
//  Created by Mephrine on 2020/05/28.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import Foundation

/**
 # toQueryString
 - Author: Mephrine
 - Date: 20.05.28
 - Parameters:
 - isEncode: 인코딩 여부
 - Returns: String
 - Note: Query 형식의 String으로 반환
 */

extension Dictionary {
    func toQueryString(isEncode: Bool = false) -> String {
        var paramData = ""
        for key in self.keys {
            if let value = self[key] as? String {
                
                if isEncode {
                    // 퍼센트 인코딩
                    var percentEncoding = CharacterSet.alphanumerics // 영문자 제외 인코딩
                    percentEncoding.insert(charactersIn: "+-_.!") // 비예약 문자 제외
                    
                    if let enValue = value.addingPercentEncoding(withAllowedCharacters: percentEncoding){
                        paramData.append("\(key)=\(enValue)"+"&")
                    }
                }else{
                    paramData.append("\(key)=\(value)"+"&")
                }
            }
        }
        
        if paramData.hasSuffix("&") {
            let startIndex = paramData.startIndex
            let endIndex = paramData.index(paramData.endIndex, offsetBy: -1)
            paramData = String(paramData[startIndex..<endIndex])
        }
        
        return paramData
    }
    
}

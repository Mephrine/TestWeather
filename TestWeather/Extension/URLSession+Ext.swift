//
//  URLSession+Ext.swift
//  TestWeather
//
//  Created by Mephrine on 2020/05/28.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

extension URLSession {
    func load<T>(_ api: API<T>, completion: @escaping (T?, Bool) -> Void) {
        dataTask(with: api.request) { data, response, error in
            // 에러 확인
            guard let response = response as? HTTPURLResponse, response.statusCode == 200, error == nil else {
                p("load api error : response or statusCode")
                completion(nil, false)
                return
            }
            
            completion(data.flatMap(api.data), true)
        }.resume()
    }
    
    func loadImage(_ url: URL, completion: @escaping (UIImage?, Bool) -> Void) {
        dataTask(with: url) { data, response, error in
            // 에러 확인
            guard let response = response as? HTTPURLResponse, response.statusCode == 200,
                let mimeType = response.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    p("load image error : response or statusCode : \(error.debugDescription)")
                    completion(nil, false)
                    return
                }
            
            completion(image, true)
        }.resume()
    }
}

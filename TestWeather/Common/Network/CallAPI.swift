//
//  CallAPI.swift
//  TestWeather
//
//  Created by Mephrine on 2020/05/28.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import Foundation

class CallAPI {
    fileprivate enum path {
        case currentWeather(lat: String, lon: String)
        case weather5Days(lat: String, lon: String)
        case currentWeatherCity(cityNm: String)
        
        private var strUrl: String {
            switch self {
            case .currentWeather(_, _), .currentWeatherCity(_):
                return "\(API_DOMAIN)/weather"
            case .weather5Days(_, _):
                return "\(API_DOMAIN)/forecast"
            }
        }
        
        // 파라미터
        private var parameters: [String: Any]? {
            switch self {
            case .currentWeather(let lat, let lon):
                return ["lat": lat, "lon": lon, "appid": API_KEY, "lang": "kr"]
            case .currentWeatherCity(let cityNm):
                return ["q": cityNm, "appid": API_KEY, "lang": "kr"]
            case .weather5Days(let lat, let lon):
            return ["lat": lat, "lon": lon, "appid": API_KEY, "lang": "kr"]
            }
        }
        
        fileprivate var pathURL: String {
            if let param = parameters?.toQueryString() {
                return "\(strUrl)?\(param)"
            }
            return "\(strUrl)"
        }
    }
    
    enum APIError: Error {
        case erroURL
        case noData
        case network
        
        var desc: String? {
            switch self {
            case .erroURL:
                return STR_NETWORK_ERROR_URL
            case .noData:
                return STR_NETWORK_NO_DATA
            case .network:
                return STR_NETWORK_CONNECT_ERROR
            }
        }
    }
    
    static let shared: CallAPI = CallAPI()
    
    private lazy var session = URLSession(configuration: .default)
    
    // MARK: - API List
    func getCurrentWeather(lat: String, lon: String, _ completion: @escaping (Result<Weather, APIError>) -> Void) {
        guard let url = URL(string: path.currentWeather(lat: lat, lon: lon).pathURL) else {
            p("getCurrentWeather error")
            DispatchQueue.main.async {
                completion(.failure(.erroURL))
            }
            return
        }
        
        let loadAPI = API<Weather>(url)
        
        session.load(loadAPI) { resultData, success in
            p("getCurrentWeather result : \(String(describing: resultData))")
            guard let data = resultData else {
                DispatchQueue.main.async {
                    completion(.failure(.noData))
                }
                return
            }
            
            if !success {
                DispatchQueue.main.async {
                    completion(.failure(.network))
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(data))
            }
        }
    }
}

struct API<T> {
    var request: URLRequest
    let data: (Data) -> T?
}

extension API where T: Decodable {
    init(_ url: URL) {
        self.request = URLRequest(url: url)
        self.data = {
            try? JSONDecoder().decode(T.self, from: $0)
        }
    }
}

//
//  WeatherRequest.swift
//  WaetherApp
//
//  Created by Abdoelrhman Eaita on 7/21/19.
//  Copyright © 2019 Abdoelrhman Eaita. All rights reserved.
//

import Foundation
import Alamofire
enum WeatherRequest: URLRequestBuilder {
    case weather(id: Int)
    case weatherLocation(coordinate: Coordinates)
    
    var path: String {
        return "weather"
    }
    
    var parameters: Parameters? {
        var param = defaultParams
        switch self {
        case .weather(let id):
            param["id"] = id
        case .weatherLocation(let coordinate):
            param["lat"] = coordinate.lat
            param["lon"] = coordinate.lon
        }
        return param
    }
    
    var method: HTTPMethod {
        return .get
    }
    
}

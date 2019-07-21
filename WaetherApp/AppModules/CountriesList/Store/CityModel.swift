//
//  CityModel.swift
//  WaetherApp
//
//  Created by Abdoelrhman Eaita on 7/17/19.
//  Copyright © 2019 Abdoelrhman Eaita. All rights reserved.
//

import Foundation

// MARK: - WelcomeElement
struct CityModel: Codable {
    let id: Int
    let name, country: String
    let coord: Coordinates
}

// MARK: - Coord
struct Coordinates: Codable {
    let lon, lat: Double
}

typealias Cities = [CityModel]

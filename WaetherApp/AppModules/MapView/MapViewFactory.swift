//
//  MapViewFactory.swift
//  WaetherApp
//
//  Created by Abdoelrhman Eaita on 7/21/19.
//  Copyright © 2019 Abdoelrhman Eaita. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
struct MapViewFactory {
    typealias Coordinates = (long: Double, lat: Double)
    
    static func makeMapWithNavigation() -> UIViewController {
        let vc = MapViewController()
        let nav = UINavigationController(rootViewController: vc)
        vc.camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        return nav
    }
    
    static func makeMapWith(_ coordinates: Coordinates) -> UIViewController {
        let vc = MapViewController()
        vc.camera = GMSCameraPosition.camera(withLatitude: coordinates.lat, longitude: coordinates.long, zoom: 6.0)
        vc.marker.position = CLLocationCoordinate2D(latitude: coordinates.lat, longitude: coordinates.long)
        return vc
    }
}

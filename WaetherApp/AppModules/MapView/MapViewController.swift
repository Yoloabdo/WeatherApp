//
//  MapViewController.swift
//  WaetherApp
//
//  Created by Abdoelrhman Eaita on 7/21/19.
//  Copyright © 2019 Abdoelrhman Eaita. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation



class MapViewController: UIViewController {
    
    
    lazy var doneBtn: UIBarButtonItem = {
        return UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissView))
    }()
    
    var camera: GMSCameraPosition?
    
    lazy var marker: GMSMarker = {
        let marker = GMSMarker()
        // Creates a marker in the center of the map.
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        return marker
    }()
    
    lazy var mapView: GMSMapView = {
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera!)
        return mapView
    }()
    
    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setRightBarButton(doneBtn, animated: true)
        view = mapView
    }
    
}

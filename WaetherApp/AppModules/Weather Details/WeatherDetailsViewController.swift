//
//  WeatherDetailsViewController.swift
//  WaetherApp
//
//  Created by Abdoelrhman Eaita on 7/21/19.
//  Copyright © 2019 Abdoelrhman Eaita. All rights reserved.
//

import UIKit

class WeatherDetailsViewController: UIViewController {
    var data: CityModel?
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var currentDegreeLabel: UILabel!
    
    @IBOutlet weak var maxDegreeLabel: UILabel!
    
    @IBOutlet weak var minimumDegreeLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    
    func loadData() {
        WeatherRequest.weather(id: data?.id ?? 0).send(WeatherResponse.self) { (response) in
            switch response {
            case .success(let value) :
                print(value)
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
}

//
//  MainTabBarViewController.swift
//  WaetherApp
//
//  Created by Abdoelrhman Eaita on 7/21/19.
//  Copyright © 2019 Abdoelrhman Eaita. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    
    lazy var countriesList: UINavigationController = {
        let vc = CountriesListViewController(nibName: "CountriesListViewController", bundle: nil)
        vc.tabBarItem.image = #imageLiteral(resourceName: "countries")
        return UINavigationController(rootViewController: vc)
    }()
    
    
    lazy var profile: UINavigationController = {
        let vc = UIViewController()
        vc.tabBarItem.title = "Profile"
        vc.tabBarItem.image = #imageLiteral(resourceName: "profile")
        return UINavigationController(rootViewController: vc)
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        setViewControllers([countriesList, profile], animated: true)
    }
    


}

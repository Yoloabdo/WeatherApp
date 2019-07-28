//
//  WeatherDetailsViewController.swift
//  WaetherApp
//
//  Created by Abdoelrhman Eaita on 7/21/19.
//  Copyright © 2019 Abdoelrhman Eaita. All rights reserved.
//

import UIKit



class WeatherDetailsViewController: UIViewController, WeatherDetailsViewModelDelegate {
  
    @IBOutlet weak var activityInidicator: UIActivityIndicatorView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var currentDegreeLabel: UILabel!
    @IBOutlet weak var maxDegreeLabel: UILabel!
    @IBOutlet weak var minimumDegreeLabel: UILabel!
    @IBOutlet weak var holderStack: UIStackView!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    
    lazy var viewModel: WeatherDetailsViewModel = {
        let vm = WeatherDetailsViewModel()
        vm.delegate = self
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadData()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.cancelDataLoading()
    }
    
   
    func animateLabels() {
        topConstraint.constant = 200
        UIView.animate(withDuration: 0.6) {
            self.view.layoutIfNeeded()
            self.backgroundImage.alpha = 1.0
        }
    }
    
    func fillViewData(data: WeatherCuratedData) {
        descriptionLabel.text = data.description
        currentDegreeLabel.text = data.currentDegree
        maxDegreeLabel.text = data.maxDegree
        minimumDegreeLabel.text = data.minDegree
    }
    
    func startActivityIndicator() {
        activityInidicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        activityInidicator.stopAnimating()
    }
}

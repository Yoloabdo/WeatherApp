//
//  CountriesListViewController.swift
//  WaetherApp
//
//  Created by Abdoelrhman Eaita on 7/17/19.
//  Copyright © 2019 Abdoelrhman Eaita. All rights reserved.
//

import UIKit


class CountriesListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var tableData: Cities?
    
    lazy var mapButton: UIBarButtonItem = {
        return UIBarButtonItem(title: "Map", style: .plain, target: self, action: #selector(openMaps))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.setLeftBarButton(mapButton, animated: true)
        
        title = "Countries"
        
        let cell = UINib(nibName: "CountryTableViewCell", bundle: nil)
        
        tableView.register(cell, forCellReuseIdentifier: "UITableViewCell")
        
        loadData()
        
    }
    
    @objc func openMaps() {
        let vc = MapViewFactory.makeMapWithNavigation()
        present(vc, animated: true, completion: nil)
    }
    
    func loadData() {
        if let path = Bundle.main.path(forResource: "city.list", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                tableData = try decoder.decode(Cities.self, from: data)
                tableView.reloadData()
            } catch {
                print(error)
            }
        }
    }
}


extension CountriesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tableData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath) as! CountryTableViewCell
        let data = tableData?[indexPath.row]
        cell.countryName?.text = data?.country
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = tableData?[indexPath.row]
        let vc = WeatherDetailsViewController()
        vc.viewModel.cityId = city?.id
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension CountriesListViewController: TableViewCellDelegate {
    func didTab(_ button: UIButton, cell: UITableViewCell) {
        guard let index = tableView.indexPath(for: cell) else { return }
        let data = tableData?[index.row]
        
        let vc = MapViewFactory.makeMapWith((data?.coord.lon ?? 0, data?.coord.lat ?? 0))
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

//
//  CountriesListViewController.swift
//  WaetherApp
//
//  Created by Abdoelrhman Eaita on 7/17/19.
//  Copyright © 2019 Abdoelrhman Eaita. All rights reserved.
//

import UIKit


class SubtitleTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



class CountriesListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var tableData: Cities?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Countries"
        
        tableView.register(SubtitleTableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        loadData()
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        let data = tableData?[indexPath.row]
        cell.textLabel?.text = data?.country
        cell.detailTextLabel?.text = "\(data?.coord.lat ?? 0) , \(data?.coord.lon ?? 0)"
        cell.imageView?.image = #imageLiteral(resourceName: "icon")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = tableData?[indexPath.row]
        
        let vc = WeatherDetailsViewController()
        vc.data = city
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}


//
//  CountryTableViewCell.swift
//  WaetherApp
//
//  Created by Abdoelrhman Eaita on 7/21/19.
//  Copyright © 2019 Abdoelrhman Eaita. All rights reserved.
//

import UIKit

protocol TableViewCellDelegate: class {
    func didTab(_ button: UIButton, cell: UITableViewCell)
}

class CountryTableViewCell: UITableViewCell {
    @IBOutlet weak var mapBtn: UIButton!
    @IBOutlet weak var countryName: UILabel!
    
    weak var delegate: TableViewCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func openOnMap(_ sender: UIButton) {
        delegate?.didTab(sender, cell: self)
    }
}

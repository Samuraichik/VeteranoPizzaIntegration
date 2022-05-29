//
//  OrderSettingsCell.swift
//  VeteranoPizza
//
//  Created by User on 31.08.2021.
//

import UIKit

class OrderSettingsCell: UITableViewCell, ReusableCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setUp(string: String) {
        
        nameLabel.text = string
        
    }
}

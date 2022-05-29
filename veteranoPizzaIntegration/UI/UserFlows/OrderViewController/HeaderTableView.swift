//
//  HeaderTableViewCell.swift
//  VeteranoPizza
//
//  Created by User on 05.10.2021.
//

import UIKit

class HeaderTableView: UIView {
    private lazy var sectionMainLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.font = UIFont(name: "AvenirNext-Bold", size: 15)
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUp(text: String) {
        sectionMainLabel.text = text
        setUpView()
    }
    
    private func setUpView() {
        self.addSubview(sectionMainLabel)
        sectionMainLabel.layout {
            $0.centerY.constraint(to: self, by: .centerY(0))
            $0.leading.constraint(to: self, by: .leading(10))
            $0.size(.width(240/375*Size.width), .height(20/812*Size.heigth))
        }
    }
}

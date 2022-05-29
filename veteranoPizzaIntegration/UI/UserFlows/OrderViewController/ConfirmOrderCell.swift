//
//  ConfirmOrderButton.swift
//  VeteranoPizzaIntegration
//
//  Created by User on 14.09.2021.
//

import UIKit

class ConfirmOrderCell: UITableViewCell, ReusableCell {
    
    public  var buttonAction: (() -> Void)?
    
    private lazy var confirmOrderButton: UIButton = {
        let button = UIButton()
//        button.contentMode = .scaleAspectFit
//        button.clipsToBounds = true
        button.layer.cornerRadius = 10
//        button.layer.masksToBounds = true
        button.setTitle("Оформити замовлення", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.init(hexString:"#861901")
        button.titleLabel?.font = FontFamily.Montserrat.semiBold.font(size: 12.0)
        button.addTarget(self, action: #selector(deleteProductButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setUpViews(){
        self.addSubview(confirmOrderButton)
        confirmOrderButton.layout {
            $0.constraint(to: self, by: .top(10),.bottom(-10),.trailing(-10),.leading(150))
        }
    }
    
    @objc private func deleteProductButtonPressed() {
        buttonAction?()
    }
}

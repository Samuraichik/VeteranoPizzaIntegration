//
//  SoucesTableViewCell.swift
//  veteranoPizzaIntegration
//
//  Created by User on 07.02.2022.
//

import Foundation
import UIKit

class SoucesTableViewCell: UITableViewCell, ReusableCell {

    var countFood = 0
    var buttonAction: (() -> Void)?
    
    private lazy var drinkImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = Size.width/3.75
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var drinkName: UILabel = {
        let foodName = UILabel()
//        foodName.adjustsFontSizeToFitWidth = true
//        foodName.minimumScaleFactor = 0.5
        foodName.numberOfLines = 0
        foodName.font = FontFamily.Montserrat.semiBold.font(size: 14)
        return foodName
    }()
    
    private lazy var drinkPrice: UILabel = {
        let foodPrice = UILabel()
//        foodPrice.adjustsFontSizeToFitWidth = true
//        foodPrice.minimumScaleFactor = 0.5
        foodPrice.numberOfLines = 0
        foodPrice.font = FontFamily.Montserrat.semiBold.font(size: 14)
        return foodPrice
    }()
    
    private lazy var chooseButton: UIButton = {
        let button = UIButton()
//        button.contentMode = .scaleAspectFit
//        button.clipsToBounds = true
        button.layer.cornerRadius = Size.width/50
//        button.layer.masksToBounds = true
        button.setTitle("Oбрати", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.init(hexString:"#861901")
        button.titleLabel?.font = FontFamily.Montserrat.semiBold.font(size: 12.0)
        button.addTarget(self, action: #selector(chooseButtonPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setUpSeparation()
        configureView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        setUpSeparation()
        configureView()
    }
    

    @IBAction func addToBuyList(_ sender: Any) {
        buttonAction?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func configureView() {
        
        self.addSubview(drinkImage)
        drinkImage.layout {
            $0.constraint(to: self, by: .top(10))
            $0.size(.width(200/375*Size.width), .height(200/375*Size.width))
            $0.centerX.constraint(to: self, by: .centerX(0))
        }
        
        self.addSubview(drinkName)
        drinkName.layout {
            $0.top.constraint(to: drinkImage, by: .bottom(10))
            $0.constraint(to: self, by: .leading(20))
            $0.size(.width(120/375*Size.width), .height(20/812*Size.heigth))
        }
        
        self.addSubview(drinkPrice)
        drinkPrice.layout {
            $0.constraint(to: self, by: .leading(20), .bottom(-20))
            $0.size(.width(300/375*Size.width), .height(20/812*Size.heigth))
        }

        self.addSubview(chooseButton)
        chooseButton.layout {
            $0.constraint(to: self, by: .trailing(-20), .bottom(-20))
            $0.size(.width(80/375*Size.width), .height(30/812*Size.heigth))
        }
        
        self.drinkImage.layer.masksToBounds = true
    }
    
    func setUp(arr: Food ) {
        drinkImage.image = arr.image
        drinkName.text = arr.name
        drinkPrice.text = "\(PriceFactory.shared.returnSoucesValue(id: arr.name))" + " uah"
        
        
    }
    
    @objc func chooseButtonPressed() {
        buttonAction?()
    }
}

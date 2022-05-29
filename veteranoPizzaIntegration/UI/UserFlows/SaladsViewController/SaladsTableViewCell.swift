//
//  SaladsTableViewCell.swift
//  veteranoPizzaIntegration
//
//  Created by User on 07.02.2022.
//

import Foundation
import UIKit

class SaladsTableViewCell: UITableViewCell, ReusableCell {
    
    public var countFood = 0
    public var buttonAction: (() -> Void)?
    
    private lazy var foodImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = Size.width/3.75
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var foodName: UILabel = {
        let foodName = UILabel()
        foodName.adjustsFontSizeToFitWidth = true
        foodName.minimumScaleFactor = 0.5
        foodName.font = FontFamily.Montserrat.semiBold.font(size: 14)
        return foodName
    }()
    
    private lazy var foodDescription: UILabel = {
        let foodDescription = UILabel()
        foodDescription.textAlignment = .left
        foodDescription.numberOfLines = 4
        foodDescription.adjustsFontSizeToFitWidth = true
        foodDescription.minimumScaleFactor = 0.5
        foodDescription.font = FontFamily.Montserrat.light.font(size: 14)
        return foodDescription
    }()
    
    private lazy var foodPrice: UILabel = {
        let foodPrice = UILabel()
        foodPrice.adjustsFontSizeToFitWidth = true
        foodPrice.minimumScaleFactor = 0.5
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
        setUpSeparation()
        configureView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpSeparation()
        configureView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    public func setUpSeparation() {
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = UIEdgeInsets.zero
        self.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }

    public func setUp(arr: Food) {
        foodImage.image = arr.image
        foodName.text = arr.name
        foodDescription.text = arr.description
        foodPrice.text = "\(PriceFactory.shared.returnSaladsValue(id: arr.name))" + " uah"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func configureView() {
        
        self.addSubview(foodImage)
        foodImage.layout {
            $0.constraint(to: self, by: .top(10))
            $0.size(.width(200/375*Size.width), .height(200/375*Size.width))
            $0.centerX.constraint(to: self, by: .centerX(0))
        }
        
        self.addSubview(foodName)
        foodName.layout {
            $0.top.constraint(to: foodImage, by: .bottom(20))
            $0.constraint(to: self, by: .leading(20))
            $0.size(.width(120/375*Size.width), .height(20/812*Size.heigth))
        }
        
        self.addSubview(foodDescription)
        foodDescription.layout {
            $0.top.constraint(to: foodName, by: .bottom(10))
            $0.constraint(to: self, by: .leading(20))
            $0.size(.width(300/375*Size.width), .height(120/812*Size.heigth))
        }
        
        self.addSubview(foodPrice)
        foodPrice.layout {
            $0.constraint(to: self, by: .leading(20), .bottom(-20))
            $0.size(.width(120/375*Size.width), .height(30/812*Size.heigth))
        }
        
        self.addSubview(chooseButton)
        chooseButton.layout {
            $0.constraint(to: self, by: .trailing(-20), .bottom(-20))
            $0.size(.width(80/375*Size.width), .height(30/812*Size.heigth))
        }
        
        self.foodImage.layer.masksToBounds = true
    }
    
    @objc func chooseButtonPressed() {
        print("gfdgdfgfdgd")
        buttonAction?()
    }
}

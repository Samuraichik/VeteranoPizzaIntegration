//
//  BasketPizzaCell.swift
//  VeteranoPizza
//
//  Created by User on 31.08.2021.
//

import UIKit

class BasketPizzaCells: UITableViewCell, ReusableCell {
    
    private lazy var foodImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = Size.width/1.825
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var foodName: UILabel = {
        let foodName = UILabel()
        foodName.adjustsFontSizeToFitWidth = true
        foodName.minimumScaleFactor = 0.5
        foodName.textAlignment = .center
        foodName.font = FontFamily.Montserrat.semiBold.font(size: 12)
        return foodName
    }()

    private lazy var foodQuantity: UILabel = {
        let foodQuantity = UILabel()
        foodQuantity.adjustsFontSizeToFitWidth = true
        foodQuantity.minimumScaleFactor = 0.5
        foodQuantity.textAlignment = .center
        foodQuantity.font = FontFamily.Montserrat.semiBold.font(size: 12)
        return foodQuantity
    }()
    
    private lazy var foodSumPrice: UILabel = {
        let foodSumPrice = UILabel()
        foodSumPrice.adjustsFontSizeToFitWidth = true
        foodSumPrice.minimumScaleFactor = 0.5
        foodSumPrice.textAlignment = .center
        foodSumPrice.font = FontFamily.Montserrat.semiBold.font(size: 12)
        return foodSumPrice
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
        setUpSeparation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpViews()
        setUpSeparation()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUp(arr: Product) {
        
        foodName.text = arr.food.name
        foodImage.image = arr.food.image
        foodSumPrice.text = "\(arr.quantity*arr.price)uah"
        foodQuantity.text =  "Кількість: " + " \(arr.quantity)"
    }
    
    private func setUpSeparation() {
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = UIEdgeInsets.zero
        self.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    private func setUpViews() {
        self.addSubview(foodImage)
        foodImage.layout {
            $0.leading.constraint(to: self, by:.leading(20))
            $0.size(.width(50/375*Size.width), .height(50/375*Size.width))
            $0.centerY.constraint(to: self, by: .centerY(0))
        }
        
        self.addSubview(foodName)
        foodName.layout {
            $0.leading.constraint(to: foodImage, by:.trailing(10))
            $0.size(.width(90/375*Size.width), .height(20/812*Size.heigth))
            $0.centerY.constraint(to: foodImage, by: .centerY(0))
        }
        
        self.addSubview(foodQuantity)
        foodQuantity.layout {
            $0.leading.constraint(to: foodName, by:.trailing(10))
            $0.size(.width(100/375*Size.width), .height(20/812*Size.heigth))
            $0.centerY.constraint(to: foodImage, by: .centerY(0))
        }
        
        self.addSubview(foodSumPrice)
        foodSumPrice.layout {
            $0.leading.constraint(to: foodQuantity, by:.trailing(10))
            $0.size(.width(60/375*Size.width), .height(20/812*Size.heigth))
            $0.centerY.constraint(to: foodImage, by: .centerY(0))
        }
    }

}

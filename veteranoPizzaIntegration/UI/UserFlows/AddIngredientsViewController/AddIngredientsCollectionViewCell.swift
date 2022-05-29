//
//  AddIngredientsCollectionViewCell.swift
//  veteranoPizzaIntegration
//
//  Created by User on 02.02.2022.
//

import Foundation
import UIKit

class AddIngredientsCollectionViewCell: UICollectionViewCell, ReusableCollectionCell {
    
    
    private lazy var ingredientImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 40
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var ingredientName: UILabel = {
        let foodName = UILabel()
        foodName.adjustsFontSizeToFitWidth = true
        foodName.minimumScaleFactor = 0.5
        foodName.textAlignment = .center
        foodName.font = FontFamily.Montserrat.semiBold.font(size: 14)
        return foodName
    }()
    
    private lazy var ingredientPrice: UILabel = {
        let foodName = UILabel()
        foodName.adjustsFontSizeToFitWidth = true
        foodName.minimumScaleFactor = 0.5
        foodName.textAlignment = .center
        foodName.font = FontFamily.Montserrat.semiBold.font(size: 8)
        return foodName
    }()
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    func setUp(image: UIImage, name: String) {
        ingredientName.text = name
        ingredientImage.image = image
        ingredientImage.layer.masksToBounds = true
        ingredientPrice.text =  "+ \((PriceFactory.shared.returnIngridientsValue(id: name) as NSNumber))грн"
    }
    
    func setUpViews() {
        self.addSubview(ingredientImage)
        ingredientImage.layout {
            $0.constraint(to: self, by: .top(20))
            $0.size(.width(80/375*Size.width), .height(80/375*Size.width))
            $0.centerX.constraint(to: self, by: .centerX(0))
        }
        
        self.addSubview(ingredientName)
        ingredientName.layout {
            $0.top.constraint(to: ingredientImage, by: .bottom(20))
            $0.centerX.constraint(to: self, by: .centerX(0))
            $0.size(.width(120/375*Size.width), .height(20/812*Size.heigth))
        }
        
        self.addSubview(ingredientPrice)
        ingredientPrice.layout {
            $0.constraint(to: self, by: .bottom(-2), .trailing(-2))
            $0.size(.width(40/375*Size.width), .height(10/812*Size.heigth))
        }
    }
}

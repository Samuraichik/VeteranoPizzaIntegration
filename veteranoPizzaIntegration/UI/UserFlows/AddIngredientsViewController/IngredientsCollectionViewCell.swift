//
//  DecriptionIngredientsCollectionViewCell.swift
//  veteranoPizzaIntegration
//
//  Created by User on 02.02.2022.
//

import Foundation
import UIKit

class IngredientsCollectionViewCell: UICollectionViewCell, ReusableCollectionCell {
    
    private lazy var pointLabel: UILabel = {
        let pointLabel = UILabel()
        pointLabel.layer.cornerRadius = Size.width/1.825
        pointLabel.contentMode = .scaleAspectFill
        pointLabel.text = "•"
        pointLabel.textColor  = UIColor.init(hexString:"#861901")
//        pointLabel.backgroundColor = UIColor.init(hexString:"#861901")
        pointLabel.font = FontFamily.Montserrat.bold.font(size: 14)
        return pointLabel
    }()
    
    private lazy var ingredientName: UILabel = {
        let foodName = UILabel()
        foodName.adjustsFontSizeToFitWidth = true
        foodName.minimumScaleFactor = 0.5
        foodName.numberOfLines = 3
        foodName.font = FontFamily.Montserrat.regular.font(size: 13)
        return foodName
    }()
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setUp(name: String) {
        let ingredName = name.capitalizingFirstLetter()
        ingredientName.text = ingredName
    }
    
    func setUpViews() {
        self.addSubview(pointLabel)
        pointLabel.layout {
            $0.constraint(to: self, by: .leading(5))
            $0.size(.width(10/375*Size.width), .height(10/375*Size.width))
            $0.centerY.constraint(to: self, by: .centerY(0))
        }
        
        self.addSubview(ingredientName)
        ingredientName.layout {
            $0.leading.constraint(to: pointLabel, by: .trailing(4))
            $0.centerY.constraint(to: self, by: .centerY(0))
            $0.size(.width(160/375*Size.width), .height(50/812*Size.heigth))
        }
    }
}

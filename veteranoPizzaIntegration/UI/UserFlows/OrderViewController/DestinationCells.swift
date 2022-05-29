//
//  DestinationCells.swift
//  VeteranoPizza
//
//  Created by User on 03.09.2021.
//

import UIKit

class DestinationCells: UITableViewCell, ReusableCell {
    
    private var destinationCellsIcons = ["icons8-круг-35 пустий", "icons8-круг-35"]
    
    private lazy var iconImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = Size.width/1.825
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var destinationInfo: UILabel = {
        let foodName = UILabel()
//        foodName.adjustsFontSizeToFitWidth = true
//        foodName.minimumScaleFactor = 0.5
        foodName.textAlignment = .left
        foodName.numberOfLines = 0
        foodName.font = FontFamily.Quicksand.bold.font(size: 13)
        return foodName
    }()
    
    private lazy var destinationDescription: UILabel = {
        let foodName = UILabel()
//        foodName.adjustsFontSizeToFitWidth = true
//        foodName.minimumScaleFactor = 0.5
        foodName.numberOfLines = 0
        foodName.textAlignment = .left
        foodName.font = FontFamily.Quicksand.bold.font(size: 10)
        return foodName
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
    
    func changeIcon(){
        self.iconImage.image = UIImage(named: destinationCellsIcons[1])
        
    }
    
    func setUp(infoStr: String, descriptStr: String, image: UIImage){
        iconImage.image = image
        destinationInfo.text = infoStr
        destinationDescription.text = descriptStr
    }
    
    private func setUpViews(){
        self.addSubview(iconImage)
        iconImage.layout {
            $0.leading.constraint(to: self, by:.leading(20))
            $0.size(.width(30/375*Size.width), .height(30/375*Size.width))
            $0.centerY.constraint(to: self, by: .centerY(0))
        }
        
        self.addSubview(destinationInfo)
        destinationInfo.layout {
            $0.leading.constraint(to: iconImage, by:.trailing(20))
            $0.trailing.constraint(to: self, by:.trailing(-5))
            $0.size(.height(20/812*Size.heigth))
            $0.top.constraint(to: self, by:.top(10))
        }
        
        self.addSubview(destinationDescription)
        destinationDescription.layout {
            $0.leading.constraint(to: iconImage, by:.trailing(20))
            $0.trailing.constraint(to: self, by:.trailing(-5))
            $0.top.constraint(to: destinationInfo, by:.bottom(10))
            $0.bottom.constraint(to: self, by:.bottom(-10))
        }
    }
    
    private func setUpSeparation() {
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = UIEdgeInsets.zero
        self.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}

//
//  PreOrderTableViewCell.swift
//  veteranoPizzaIntegration
//
//  Created by User on 04.02.2022.
//

import Foundation
import UIKit

class PreOrderTableViewCell: UITableViewCell, ReusableCell {
    
    public var product: Product?
    
    public  var buttonAction: (() -> Void)?
    
    private lazy var foodImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = Size.width/11
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var foodName: UILabel = {
        let foodName = UILabel()
        foodName.adjustsFontSizeToFitWidth = true
        foodName.minimumScaleFactor = 0.5
        foodName.textAlignment = .center
        foodName.font = FontFamily.Montserrat.semiBold.font(size: 14)
        return foodName
    }()
    
    private lazy var descriptionIngredientsCollView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 80/375*Size.width, height: 30/812*Size.heigth)
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        IngredientsCollectionViewCell.register(for: collectionView)
        collectionView.isScrollEnabled = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isUserInteractionEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var foodSize: UILabel = {
        let foodSize = UILabel()
        foodSize.numberOfLines = 1
        foodSize.adjustsFontSizeToFitWidth = true
        foodSize.minimumScaleFactor = 0.5
        foodSize.textAlignment = .right
        foodSize.font = FontFamily.Montserrat.semiBold.font(size: 12)
        return foodSize
    }()
    
    private lazy var foodQuantity: UILabel = {
        let foodQuantity = UILabel()
        foodQuantity.numberOfLines = 1
        foodQuantity.adjustsFontSizeToFitWidth = true
        foodQuantity.minimumScaleFactor = 0.5
        foodQuantity.textAlignment = .right
        foodQuantity.font = FontFamily.Montserrat.semiBold.font(size: 12)
        return foodQuantity
    }()
    
    private lazy var foodPrice: UILabel = {
        let foodPrice = UILabel()
        foodPrice.adjustsFontSizeToFitWidth = true
        foodPrice.minimumScaleFactor = 0.5
        foodPrice.font = FontFamily.Montserrat.semiBold.font(size: 12)
        foodPrice.textAlignment = .right
        return foodPrice
    }()
    
    private lazy var deleteProdButton: UIButton = {
        let button = UIButton()
//        button.contentMode = .scaleAspectFit
//        button.clipsToBounds = true
//        button.layer.cornerRadius = Size.width/50
//        button.layer.masksToBounds = true
        button.setTitle("x", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.lightGray
        button.titleLabel?.font = FontFamily.Montserrat.semiBold.font(size: 12.0)
        button.addTarget(self, action: #selector(deleteProductButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var additionalIngridientsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .left
        label.text = "Додаткові ігрідієнти:"
        label.font = FontFamily.Montserrat.semiBold.font(size: 12)
        return label
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
    
    @IBAction func deleteButton(_ sender: Any) {
        buttonAction?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //    func refreshData(){
    //        if let product = self.product {
    //            setUp(arr: product)
    //        }
    //    }
    
    private func setUpViews() {
        self.addSubview(foodImage)
        foodImage.layout {
            $0.constraint(to: self, by: .top(20), .leading(10))
            $0.size(.width(70/375*Size.width), .height(70/375*Size.width))
        }
        
        self.addSubview(foodName)
        foodName.layout {
            $0.bottom.constraint(to: self, by: .bottom(-5))
            $0.centerX.constraint(to: foodImage, by: .centerX(0))
            $0.size(.width(90/375*Size.width), .height(20/812*Size.heigth))
        }
        
        self.addSubview(foodPrice)
        foodPrice.layout {
            $0.constraint(to: self, by: .trailing(-5), .bottom(-5))
            $0.size(.width(120/375*Size.width), .height(30/812*Size.heigth))
        }
        
        self.addSubview(foodQuantity)
        foodQuantity.layout {
            $0.bottom.constraint(to: foodPrice, by: .top(-7))
            $0.constraint(to: self, by: .trailing(-5))
            $0.size(.width(80/375*Size.width), .height(20/812*Size.heigth))
        }

        self.addSubview(foodSize)
        foodSize.layout {
            $0.bottom.constraint(to: foodQuantity, by: .top(-7))
            $0.constraint(to: self, by: .trailing(-5))
            $0.size(.width(80/375*Size.width), .height(20/812*Size.heigth))
        }
        
        self.addSubview(additionalIngridientsLabel)
        additionalIngridientsLabel.layout {
            $0.leading.constraint(to: foodImage, by: .trailing(10))
            $0.trailing.constraint(to: foodSize, by: .leading(-4))
            $0.constraint(to: self, by: .top(5))
            $0.size(.height(30/812*Size.heigth))
        }
        
        self.addSubview(descriptionIngredientsCollView)
        descriptionIngredientsCollView.layout {
            $0.leading.constraint(to: foodImage, by: .trailing(10))
            $0.trailing.constraint(to: foodSize, by: .leading(-4))
            $0.constraint(to: self, by: .bottom(-5))
            $0.top.constraint(to: additionalIngridientsLabel, by: .bottom(2))
        }
        
        self.addSubview(deleteProdButton)
        deleteProdButton.layout {
            $0.constraint(to: self, by: .top(5), .trailing(-5))
            $0.size(.height(30),.width(30))
        }
        
        self.foodImage.layer.masksToBounds = true
    }
    
    func setUpSeparation() {
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = UIEdgeInsets.zero
        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func setUp(product: Product) {
        self.product = product
        foodName.text = product.food.name
        foodImage.image = product.food.image
        if product.size == 0 {
            foodSize.isHidden = true
        }else {
            
            foodSize.text = "Розмір: " + "\(Float(truncating: product.size as! NSNumber).clean)"
        }
        foodPrice.text = "Ціна: "+"\(product.quantity*product.price)" + "грн"
        foodQuantity.text = "Кількість: " + "\(product.quantity)"

        setUpAddIngrients()
    }
    
    func setUpAddIngrients() {
        
        if (product?.food.options.count != 0) {
            self.additionalIngridientsLabel.isHidden = false
            self.descriptionIngredientsCollView.isHidden = false
        }else {
            self.additionalIngridientsLabel.isHidden = true
            self.descriptionIngredientsCollView.isHidden = true
        }
    
    }
    
    @objc private func deleteProductButtonPressed() {
        buttonAction?()
    }
}

extension Float {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

extension PreOrderTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.product?.food.options.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let collectionViewCell = IngredientsCollectionViewCell.deque(for: collectionView, indexPath: indexPath) else { return UICollectionViewCell() }
        collectionViewCell.setUpViews()
        collectionViewCell.setUp(name: (self.product?.food.options[indexPath.row].title) ?? "")
        return collectionViewCell
    }
}

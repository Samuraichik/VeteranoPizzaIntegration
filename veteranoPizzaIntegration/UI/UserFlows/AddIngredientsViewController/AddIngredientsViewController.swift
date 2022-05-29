//
//  AddIngredientsViewController.swift
//  veteranoPizzaIntegration
//
//  Created by User on 02.02.2022.
//

import Foundation
import UIKit

class AddIngredientsViewController: UIViewController, DoubleDismissableViewController {
    
    public var onDismiss: (() -> Void)?
    public var food: Food?
    var ingridients = VeteranoInfo.shared.getIngridientArr()
    var delegate: FoodDelegateProtocol?
    var removedIngridients: String?
    
    private var additionalPrice: Int!
    private var foodOptions = [Option]()
    private var ingredientsArr: [String]?
    
    private lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 1215)
    
    private lazy var backgroundView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.contentSize = contentViewSize
        scrollView.backgroundColor = .white
        scrollView.frame = self.view.bounds
        scrollView.autoresizingMask = .flexibleHeight
        scrollView.bounces = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.frame.size = contentViewSize
        return view
    }()
    
    private lazy var descriptionView: UIView = {
        let mainView = UIView()
        mainView.backgroundColor = .white
        mainView.isUserInteractionEnabled = true
        mainView.translatesAutoresizingMaskIntoConstraints = false
        return mainView
    }()
    
    private lazy var addIngredientsLabel: UILabel = {
        let ingredientsLabel = UILabel()
        ingredientsLabel.adjustsFontSizeToFitWidth = true
        ingredientsLabel.minimumScaleFactor = 0.5
        ingredientsLabel.font = FontFamily.Montserrat.bold.font(size: 16)
        ingredientsLabel.text = "Додаткові інгрідієнти(+50г): "
        ingredientsLabel.textColor = .black
        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        return ingredientsLabel
    }()
    
    private lazy var ingredientsLabel: UILabel = {
        let ingredientsLabel = UILabel()
        ingredientsLabel.adjustsFontSizeToFitWidth = true
        ingredientsLabel.minimumScaleFactor = 0.5
        ingredientsLabel.font = FontFamily.Montserrat.bold.font(size: 16)
        ingredientsLabel.text = "Основні інгрідієнти: "
        ingredientsLabel.textColor = .black
        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        return ingredientsLabel
    }()
    
    private lazy var deleteIngredientsLabel: UILabel = {
        let ingredientsLabel = UILabel()
        ingredientsLabel.adjustsFontSizeToFitWidth = true
        ingredientsLabel.minimumScaleFactor = 0.5
        ingredientsLabel.font = FontFamily.Montserrat.bold.font(size: 16)
        ingredientsLabel.text = "Не додавати до піци:"
        ingredientsLabel.textColor = .black
        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        return ingredientsLabel
    }()
    
    
    private lazy var descriptionIngredientsCollView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 170/375*Size.width, height: 60/812*Size.heigth)
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
        collectionView.allowsMultipleSelection = true
        return collectionView
    }()
    
    private lazy var ingredientsCollectionViewView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 170/375*Size.width, height: 180/812*Size.heigth)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 5
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        AddIngredientsCollectionViewCell.register(for: collectionView)
        collectionView.isScrollEnabled = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsMultipleSelection = true
        return collectionView
    }()
    
    private lazy var textView: UITextView = {
        let view = UITextView()
        view.layer.cornerRadius = 5
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 2
        view.textContainer.maximumNumberOfLines = 2
        view.font = FontFamily.Montserrat.bold.font(size: 12.0)
        view.textColor = UIColor.lightGray
        view.textAlignment = NSTextAlignment.natural
        view.text = "Не додавати до піци:"
        view.delegate = self
        
        return view
    }()
    
    private lazy var additionalPriceLabel: UILabel = {
        let ingredientsLabel = UILabel()
        ingredientsLabel.adjustsFontSizeToFitWidth = true
        ingredientsLabel.minimumScaleFactor = 0.5
        ingredientsLabel.font = FontFamily.Montserrat.bold.font(size: 18)
        ingredientsLabel.text = "+0Uah"
        ingredientsLabel.textColor = .black
        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        return ingredientsLabel
    }()
    
    private lazy var applyButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.numberOfLines = 1
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.lineBreakMode = .byClipping
        //        button.contentMode = .scaleAspectFit
        //        button.clipsToBounds = true
        button.layer.cornerRadius = Size.width/30
        //        button.layer.masksToBounds = true
        button.setTitle("Додати до замовлення", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor =  UIColor.init(hexString:"#861901")
        button.titleLabel?.font = FontFamily.Montserrat.semiBold.font(size: 11.0)
        button.addTarget(self, action: #selector(applyButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        //        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        additionalPrice = 0
        setUpNavBar()
        setUp()
        setUpViews()
        setUpIngredientsArr()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    private func setUpIngredientsArr() {
        ingredientsArr = food?.description.components(separatedBy: ", ")
    }
    
    private func setUpNavBar() {
        applyDefaultNavigationBar()
        let backButton = UIBarButtonItem(image: Asset.backButton.image,
                                         style: .done,
                                         target: self,
                                         action: #selector(backButtonButtonTapped))
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func setUp() {
        
    }
    
    private func setUpViews() {
        
        view.addSubview(backgroundView)
        backgroundView.addSubview(contentView)
        
        contentView.addSubview(descriptionView)
        descriptionView.layout {
            $0.constraint(to: contentView, by: .top(5) ,.leading(5), .trailing(-5))
            $0.size(.height(260/812*Size.heigth))
        }
        
        descriptionView.addSubview(ingredientsLabel)
        ingredientsLabel.layout {
            $0.constraint(to: contentView, by: .top(10), .leading(15))
            $0.size(.width(180/375*Size.width), .height(60/812*Size.heigth))
        }
        
        descriptionView.addSubview(descriptionIngredientsCollView)
        descriptionIngredientsCollView.layout {
            $0.top.constraint(to: ingredientsLabel, by: .bottom(-5))
            $0.constraint(to: contentView, by: .leading(7), .trailing(-7))
            $0.size(.height(200/812*Size.heigth))
        }
        
        contentView.addSubview(addIngredientsLabel)
        addIngredientsLabel.layout {
            $0.top.constraint(to: descriptionView, by: .bottom(5))
            $0.leading.constraint(to: contentView, by: .leading(15))
            $0.size(.width(240/375*Size.width), .height(60/812*Size.heigth))
        }
        
        contentView.addSubview(ingredientsCollectionViewView)
        ingredientsCollectionViewView.layout {
            $0.constraint(to: contentView, by: .trailing(-5), .leading(5))
            $0.top.constraint(to: addIngredientsLabel, by: .bottom(10))
            $0.size(.height(1700/812*Size.heigth))
        }
        
        contentView.addSubview(deleteIngredientsLabel)
        deleteIngredientsLabel.layout {
            $0.top.constraint(to: ingredientsCollectionViewView, by: .bottom(5))
            $0.leading.constraint(to: contentView, by: .leading(15))
            $0.size(.width(250/375*Size.width), .height(60/812*Size.heigth))
        }
        
        contentView.addSubview(textView)
        textView.layout {
            $0.top.constraint(to: deleteIngredientsLabel, by: .bottom(10))
            $0.leading.constraint(to: contentView, by: .leading(15))
            $0.size(.width(300/375*Size.width), .height(60/812*Size.heigth))
        }
        
        
        contentView.addSubview(applyButton)
        applyButton.layout {
            $0.top.constraint(to: textView, by: .bottom(20))
            $0.trailing.constraint(to: contentView, by: .trailing(-15))
            $0.size(.width(140/375*Size.width), .height(70/812*Size.heigth))
        }
        
        contentView.addSubview(additionalPriceLabel)
        additionalPriceLabel.layout {
            $0.centerY.constraint(to: applyButton, by: .centerY(0))
            $0.leading.constraint(to: contentView, by: .leading(15))
            $0.size(.width(250/375*Size.width), .height(60/812*Size.heigth))
        }
        
        
    }
    
    @objc private func backButtonButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func applyButtonPressed() {
        self.food?.options = foodOptions
        removedIngridients = textView.text
        self.delegate?.sendData(myData: self.food!, removedIngridients: removedIngridients)
        navigationController?.popViewController(animated: true)
        
    }
}

extension AddIngredientsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView  == self.descriptionIngredientsCollView {
            return ingredientsArr!.count
        }else {
            return ingridients.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.identifier, for: indexPath) as! MyCollectionViewCell
        //        cell.ingredientName.text = items[indexPath.row]
        //        cell.ingredientImage.image = UIImage(named: itemsImage[indexPath.row])
        //        cell.layer.borderColor = UIColor.lightGray.cgColor
        //        cell.layer.borderWidth = 0.5
        //        for i in food.options{
        //            if (i.title == items[indexPath.row]) {
        //                cell.layer.borderColor = UIColor.black.cgColor
        //                cell.layer.borderWidth = 2
        //            }
        //        }
        //        return cell
        
        if collectionView == self.descriptionIngredientsCollView {
            guard let collectionViewCell = IngredientsCollectionViewCell.deque(for: collectionView, indexPath: indexPath) else { return UICollectionViewCell() }
            collectionViewCell.setUpViews()
            collectionViewCell.setUp(name: self.ingredientsArr![indexPath.row])
            return collectionViewCell
        }else {
            guard let collectionViewCell = AddIngredientsCollectionViewCell.deque(for: collectionView, indexPath: indexPath) else { return UICollectionViewCell() }
            collectionViewCell.setUpViews()
            
            if ((food?.options.isEmpty) != nil){
                collectionViewCell.layer.borderColor = UIColor.black.cgColor
                collectionViewCell.layer.borderWidth = 0.5
            }else {
                for i in food!.options{
                    if (i.title == ingridients[indexPath.row]) {
                        collectionViewCell.layer.borderColor = UIColor.black.cgColor
                        collectionViewCell.layer.borderWidth = 2
                    }else {
                        collectionViewCell.layer.borderColor = UIColor.black.cgColor
                        collectionViewCell.layer.borderWidth = 0.5
                    }
                }
            }
            
            collectionViewCell.setUp(image: UIImage(named: ingridients[indexPath.row]) ?? UIImage(), name: ingridients[indexPath.row])
            return collectionViewCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.ingredientsCollectionViewView {
            
            let cell = collectionView.cellForItem(at: indexPath)
            cell?.layer.borderColor = UIColor.black.cgColor
            cell?.layer.borderWidth = 2
            
            additionalPrice += Int(truncating: PriceFactory.shared.returnIngridientsValue(id: ingridients[indexPath.row]) as NSNumber)
            
            
            self.additionalPriceLabel.text = "+" + "\(additionalPrice!)" + " uah"
            let tempOption = Option(price: PriceFactory.shared.returnIngridientsValue(id: ingridients[indexPath.row]), title: ingridients[indexPath.row])
            foodOptions.append(tempOption)
//
//            self.foodOptions.price =  Decimal(Int(truncating: additionalPrice as NSNumber))
//            self.foodOptions.title = ingridients[indexPath.row]
//
//            self.food.options.append(foodOptions)
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == self.ingredientsCollectionViewView {
            let cell = collectionView.cellForItem(at: indexPath)
            cell?.layer.borderColor = UIColor.black.cgColor
            cell?.layer.borderWidth = 0.5
            additionalPrice -= Int(truncating: PriceFactory.shared.returnIngridientsValue(id: ingridients[indexPath.row]) as NSNumber)
            self.additionalPriceLabel.text = "+" + "\(additionalPrice!)" + " uah"
            var j = 0
            for i in foodOptions{
                if i.title == ingridients[indexPath.row]{
                    foodOptions.remove(at: j)
                }
                j += 1
            }
        }
    }
}

extension AddIngredientsViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty || textView.text == " " {
            textView.text = "Не додавати до піци:"
            textView.textColor = UIColor.lightGray
        }
    }
}

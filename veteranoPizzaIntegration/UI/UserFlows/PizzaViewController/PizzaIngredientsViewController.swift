//
//  IngredientsViewController.swift
//  veteranoPizzaIntegration
//
//  Created by User on 30.01.2022.
//

import Foundation
import UIKit

protocol FoodDelegateProtocol {
    func sendData(myData: Food , removedIngridients: String?)
}

class PizzaIngredientsViewController: UIViewController, FoodDelegateProtocol{
    
    public var food: Food!
    private let addIngridientsVC = AddIngredientsViewController()
    private let sizeArr = ["30", "40"]
    var pizzaPrice30 = 0
    var addFoodbuttonAction: (() -> Void)?
    var currentSize: Decimal = 30
    var currentPrice = 0
    var quantity = 1
    var removedIngridients: String?
    
    private lazy var mainView: UIView = {
        let mainView = UIView()
        mainView.layer.cornerRadius = Size.width/10
        mainView.layer.borderColor = UIColor.darkGray.cgColor
        mainView.layer.borderWidth = 0.5
        mainView.backgroundColor = .white
        mainView.isUserInteractionEnabled = true
        return mainView
    }()
    
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
        foodName.font = FontFamily.Montserrat.bold.font(size: 14)
        return foodName
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        //        button.contentMode = .scaleAspectFit
        //        button.clipsToBounds = true
        button.layer.cornerRadius = Size.width/30
        //        button.layer.masksToBounds = true
        button.setTitle("Назад", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .lightGray
        button.titleLabel?.font = FontFamily.Montserrat.semiBold.font(size: 12.0)
        button.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        button.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        return button
    }()
    
    private lazy var foodWeight: UILabel = {
        let foodDescription = UILabel()
        foodDescription.textAlignment = .left
        foodDescription.numberOfLines = 1
        foodDescription.adjustsFontSizeToFitWidth = true
        foodDescription.minimumScaleFactor = 0.5
        foodDescription.font = FontFamily.Montserrat.semiBold.font(size: 14)
        return foodDescription
    }()
    
    private lazy var sizeLabel: UILabel = {
        let sizeLabel = UILabel()
        sizeLabel.textAlignment = .left
        sizeLabel.adjustsFontSizeToFitWidth = true
        sizeLabel.minimumScaleFactor = 0.5
        sizeLabel.text = "Розмір: "
        sizeLabel.font = FontFamily.Montserrat.bold.font(size: 14)
        return sizeLabel
    }()
    
    private lazy var addCompLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.text = "Додати компоненти:"
        label.font = FontFamily.Montserrat.bold.font(size: 14)
        return label
    }()
    
    private lazy var sizePicker: UIPickerView = {
        let sizePicker = UIPickerView()
        sizePicker.delegate = self
        sizePicker.dataSource = self
        return sizePicker
    }()
    
    private lazy var stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.addTarget(self, action: #selector(stepperChanged), for: .valueChanged)
        stepper.stepValue = Double(currentPrice)
        stepper.value = stepper.stepValue
        stepper.maximumValue = 100000
        stepper.minimumValue = Double(currentPrice)
        return stepper
    }()
    
    private lazy var addCompView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = Asset.addComponentsImage.image
        image.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.compViewDidTap))
        image.addGestureRecognizer(tap)
        return image
    }()
    
    private lazy var quantityLabel: UILabel = {
        let quantityLabel = UILabel()
        quantityLabel.textAlignment = .left
        quantityLabel.adjustsFontSizeToFitWidth = true
        quantityLabel.minimumScaleFactor = 0.5
        quantityLabel.text = "Кількість:"
        quantityLabel.textColor = .black
        quantityLabel.font = FontFamily.Montserrat.bold.font(size: 14)
        return quantityLabel
    }()
    
    private lazy var priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.textAlignment = .left
        priceLabel.adjustsFontSizeToFitWidth = true
        priceLabel.minimumScaleFactor = 0.5
        priceLabel.font = FontFamily.Montserrat.bold.font(size: 14)
        return priceLabel
    }()
    
    private lazy var countLabel: UILabel = {
        let countLabel = UILabel()
        countLabel.adjustsFontSizeToFitWidth = true
        countLabel.minimumScaleFactor = 0.5
        countLabel.text = "1"
        countLabel.font = FontFamily.Montserrat.bold.font(size: 12)
        return countLabel
    }()
    
    private lazy var addToBasketButton: UIButton = {
        let button = UIButton()
                button.contentMode = .scaleAspectFit
                button.clipsToBounds = true
        button.layer.cornerRadius = Size.width/30
                button.layer.masksToBounds = true
        button.setTitle("Додати в кошик", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.init(hexString:"#861901")
        button.titleLabel?.font = FontFamily.Montserrat.semiBold.font(size: 12.0)
        button.addTarget(self, action: #selector(addToBasketButtonPressed), for: .touchUpInside)
        button.titleLabel?.minimumScaleFactor = 0.5
        return button
    }()

    func sendData(myData: Food, removedIngridients: String?) {
        self.food = myData
        self.removedIngridients = removedIngridients
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .clear
        addIngridientsVC.delegate = self
        
        currentPrice = Int(truncating: PriceFactory.shared.returnFoodValue(id: food.name) as NSNumber)
        setUpViews()
        setUpGesture()
        setUp()
        
    }
    
    private func setUpGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    private func setUp() {
        

        foodImage.image = food.image
        foodName.text = food.name
        foodWeight.text = "Вага: \(WeightFactory.shared.returnPizzaWeight(id: food.name, size: 30))г"
        priceLabel.text = "\(currentPrice)" + "uah"
        
        stepper.stepValue = Double(currentPrice)
        stepper.value = stepper.stepValue
        
        quantity = Int(stepper.value / stepper.stepValue)
        
    }
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        super.prepare(for: segue, sender: sender)
    //
    //        addDoubleDismiss(for: segue)$__lazy_storage_$_stepper    UIStepper?    nil    none
    //
    //        if let indredVc = (segue.destination as? UINavigationController)?.viewControllers.first as? AddIngredientsViewController {
    //            indredVc.food = self.food
    //        }
    //    }
    
    private func setUpViews() {
        self.view.addSubview(mainView)
        mainView.layout {
            $0.size(.width(350/375*Size.width), .height(500/812*Size.heigth))
            $0.centerX.constraint(to: view, by: .centerX(0))
            $0.centerY.constraint(to: view, by: .centerY(0))
        }
        
        mainView.addSubview(foodImage)
        foodImage.layout {
            $0.constraint(to: mainView, by: .top(25/812*Size.heigth))
            $0.size(.width(150/375*Size.width), .height(150/375*Size.width))
            $0.centerX.constraint(to: mainView, by: .centerX(0))
        }
        
        mainView.addSubview(backButton)
        backButton.layout {
            $0.constraint(to: mainView, by: .top(20/812*Size.heigth), .leading(15/375*Size.width))
            $0.size(.width(70/375*Size.width), .height(40/812*Size.heigth))
        }
        
        mainView.addSubview(foodName)
        foodName.layout {
            $0.constraint(to: mainView, by: .leading(15/375*Size.width))
            $0.top.constraint(to: foodImage, by: .bottom(10/812*Size.heigth))
            $0.size(.width(70/375*Size.width), .height(30/812*Size.heigth))
        }
        
        mainView.addSubview(foodWeight)
        foodWeight.layout {
            $0.trailing.constraint(to: mainView, by: .trailing(-15/375*Size.width))
//            $0.top.constraint(to: foodName, by: .bottom(5))
            $0.centerY.constraint(to:foodName , by: .centerY(0))
            $0.size(.width(90/375*Size.width), .height(50/812*Size.heigth))
        }
        
        mainView.addSubview(sizeLabel)
        sizeLabel.layout {
            $0.constraint(to: mainView, by: .leading(15/375*Size.width))
            $0.top.constraint(to: foodWeight, by: .bottom(5/812*Size.heigth))
            $0.size(.width(60/375*Size.width), .height(20/812*Size.heigth))
        }
        
        mainView.addSubview(addCompLabel)
        addCompLabel.layout {
            $0.constraint(to: mainView, by: .trailing(-20/375*Size.width))
            $0.top.constraint(to: foodWeight, by: .bottom(5/812*Size.heigth))
            $0.size(.width(160/375*Size.width), .height(20/375*Size.width))
        }
        
        mainView.addSubview(sizePicker)
        sizePicker.layout {
            $0.constraint(to: mainView, by: .leading(10/375*Size.width))
            $0.top.constraint(to: sizeLabel, by: .bottom(5/812*Size.heigth))
            $0.size(.width(130/375*Size.width), .height(80/812*Size.heigth))
        }
        
        mainView.addSubview(addCompView)
        addCompView.layout {
            $0.centerX.constraint(to: addCompLabel, by: .centerX(0))
            $0.top.constraint(to: addCompLabel, by: .bottom(15/812*Size.heigth))
            $0.size(.width(40/375*Size.width), .height(40/375*Size.width))
        }
        
        mainView.addSubview(quantityLabel)
        quantityLabel.layout {
            $0.constraint(to: mainView, by: .leading(15/375*Size.width))
            $0.top.constraint(to: sizePicker, by: .bottom(20/812*Size.heigth))
            $0.size(.width(80/375*Size.width), .height(20/812*Size.heigth))
        }
        
        mainView.addSubview(addToBasketButton)
        addToBasketButton.layout {
            $0.constraint(to: mainView, by: .trailing(-10/375*Size.width), .bottom(-15))
            $0.size(.width(120/375*Size.width), .height(60/812*Size.heigth))
        }
        
        mainView.addSubview(stepper)
        stepper.layout {
            $0.trailing.constraint(to: addToBasketButton, by: .leading(-10/375*Size.width))
            $0.centerY.constraint(to: addToBasketButton, by: .centerY(addToBasketButton.frame.origin.y/2))
        }
        
        mainView.addSubview(priceLabel)
        priceLabel.layout {
            $0.constraint(to: mainView, by: .leading(15/375*Size.width))
            $0.centerY.constraint(to: stepper, by: .centerY(addToBasketButton.frame.origin.y/2))
            $0.size(.width(80/375*Size.width), .height(20/812*Size.heigth))
        }
        
        mainView.addSubview(countLabel)
        countLabel.layout {
            $0.top.constraint(to: sizePicker, by: .bottom(20/812*Size.heigth))
            $0.centerX.constraint(to: stepper, by: .centerX(6/375*Size.width))
            $0.size(.width(20/375*Size.width), .height(20/812*Size.heigth))
        }
    }
    
    @objc func backButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func addToBasketButtonPressed() {
        
        OrderService.shared.addProduct(.init(food:self.food, quantity: Int(quantity), size: currentSize, price: currentPrice, removedIngridients: removedIngridients ?? ""))
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func compViewDidTap() {
        
        addIngridientsVC.food = self.food
        navigationController?.pushViewController(addIngridientsVC, animated: true)
    }
    
    @objc func stepperChanged(_ sender: UIStepper) {
        quantity = Int(stepper.value / stepper.stepValue)
        countLabel.text = "\(Int(quantity))"
        priceLabel.text = "\(Int(sender.value))" + "uah"
    }
}

extension PizzaIngredientsViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sizeArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if sizeArr[row] == "30" {
            currentSize = 30
            currentPrice = Int(truncating: PriceFactory.shared.returnFoodValue(id: food.name) as NSNumber)
            foodWeight.text = "Вага: \(WeightFactory.shared.returnPizzaWeight(id: food.name, size: 30))г"
            stepper.stepValue = Double(currentPrice)
            stepper.value = stepper.stepValue * Double((quantity))
            
            priceLabel.text = "\(currentPrice * Int(quantity))" + "uah"
            
        }else if sizeArr[row] == "40" {
            currentSize = 40
            currentPrice += 20
            
            foodWeight.text = "Вага: \(WeightFactory.shared.returnPizzaWeight(id: food.name, size: 40))г"
            priceLabel.text = "\(currentPrice * Int(quantity))" + "uah"
            
            stepper.stepValue = Double(currentPrice)
            stepper.value = stepper.stepValue * Double((quantity))
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sizeArr[row]
    }
    
    
}

extension PizzaIngredientsViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: mainView) == true {
            return false
        }
        return true
    }
}

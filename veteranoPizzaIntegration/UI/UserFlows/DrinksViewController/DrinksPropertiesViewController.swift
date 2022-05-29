//
//  DrinksPropertiesViewController.swift
//  veteranoPizzaIntegration
//
//  Created by User on 07.02.2022.
//

import Foundation
import UIKit


class DrinksPropertiesViewController: UIViewController {

    let sizeArr = ["0.5", "1"]
    var drinkPrice = Int()
    var food: Food!
    var quantity: Double!
    var currentSize: Decimal = 0.5
    var currentPrice = 0
    
    private lazy var mainView: UIView = {
        let mainView = UIView()
        mainView.layer.cornerRadius = Size.width/10
        mainView.layer.borderColor = UIColor.darkGray.cgColor
        mainView.layer.borderWidth = 0.5
        mainView.backgroundColor = .white
        mainView.isUserInteractionEnabled = true
        return mainView
    }()
    
    private lazy var drinkImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = Size.width/5
        image.contentMode = .scaleAspectFill
        return image
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
        
        return button
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
        countLabel.textAlignment = .center
        countLabel.font = FontFamily.Montserrat.bold.font(size: 12)
        return countLabel
    }()
    
    private lazy var addToBasketButton: UIButton = {
        let button = UIButton()
        //        button.contentMode = .scaleAspectFit
        //        button.clipsToBounds = true
        button.layer.cornerRadius = Size.width/30
        button.setTitle("Додати в кошик", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.init(hexString:"#861901")
        button.titleLabel?.font = FontFamily.Montserrat.semiBold.font(size: 12.0)
        button.addTarget(self, action: #selector(addToBasketButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentPrice = Int(truncating: PriceFactory.shared.returnDrinksValue(id: food.name) as NSNumber)
        setUpViews()
        setUp()
    }
    
    private func setUp() {
        stepper.stepValue = Double(currentPrice)
        stepper.value = stepper.stepValue
        
        quantity = Double(Int(stepper.value / stepper.stepValue))
    
        priceLabel.text = "\(currentPrice)"
        
        drinkImage.image = food.image
        self.drinkImage.layer.masksToBounds = true
    }
    
    private func setUpViews() {
        self.view.addSubview(mainView)
        mainView.layout {
            $0.size(.width(350/375*Size.width), .height(450/812*Size.heigth))
            $0.centerX.constraint(to: view, by: .centerX(0))
            $0.centerY.constraint(to: view, by: .centerY(0))
        }
        
        mainView.addSubview(drinkImage)
        drinkImage.layout {
            $0.constraint(to: mainView, by: .top(25))
            $0.size(.width(150/375*Size.width), .height(150/375*Size.width))
            $0.centerX.constraint(to: mainView, by: .centerX(0))
        }
        
        mainView.addSubview(backButton)
        backButton.layout {
            $0.constraint(to: mainView, by: .top(20), .leading(15))
            $0.size(.width(70/375*Size.width), .height(40/812*Size.heigth))
        }

        mainView.addSubview(sizeLabel)
        sizeLabel.layout {
            $0.constraint(to: mainView, by: .leading(15))
            $0.top.constraint(to: drinkImage, by: .bottom(25))
            $0.size(.width(60/375*Size.width), .height(20/812*Size.heigth))
        }

        mainView.addSubview(sizePicker)
        sizePicker.layout {
            $0.centerY.constraint(to: sizeLabel, by: .centerY(0))
            $0.centerX.constraint(to: mainView, by: .centerX(0))
            $0.size(.width(130/375*Size.width), .height(80/812*Size.heigth))
        }
        
        mainView.addSubview(quantityLabel)
        quantityLabel.layout {
            $0.constraint(to: mainView, by: .leading(15))
            $0.top.constraint(to: sizeLabel, by: .bottom(60))
            $0.size(.width(80/375*Size.width), .height(20/812*Size.heigth))
        }
        
        mainView.addSubview(stepper)
        stepper.layout {
            $0.centerX.constraint(to: mainView, by: .centerX(0))
            $0.centerY.constraint(to: quantityLabel, by: .centerY(0))
        }

        mainView.addSubview(countLabel)
        countLabel.layout {
            $0.centerX.constraint(to: mainView, by: .centerX(0))
            $0.bottom.constraint(to: stepper, by: .top(-10))
            $0.size(.width(20/375*Size.width), .height(20/812*Size.heigth))
        }
        mainView.addSubview(priceLabel)
        priceLabel.layout {
            $0.constraint(to: mainView, by: .leading(15))
            $0.top.constraint(to:quantityLabel , by: .bottom(35))
            $0.size(.width(80/375*Size.width), .height(20/812*Size.heigth))
        }
        
        mainView.addSubview(addToBasketButton)
        addToBasketButton.layout {
            $0.trailing.constraint(to: mainView,by: .trailing(-15))
            $0.size(.width(120/375*Size.width), .height(60/812*Size.heigth))
            $0.centerY.constraint(to: priceLabel, by: .centerY(0))
        }
    }
    
    @objc func backButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func addToBasketButtonPressed() {
        OrderService.shared.addProduct(.init(food:self.food, quantity: Int(quantity), size: currentSize, price: currentPrice, removedIngridients: nil))
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true, completion: nil)
    }
    

    @objc func stepperChanged(_ sender: UIStepper) {
        quantity = Double(Int(stepper.value / stepper.stepValue))
        countLabel.text = "\(Int(quantity))"
        priceLabel.text = "\(Int(sender.value))" + "uah"
    }
}

extension DrinksPropertiesViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sizeArr.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if sizeArr[row] == "0.5" {
            currentSize = 0.5
            currentPrice = Int(truncating: PriceFactory.shared.returnDrinksValue(id: food.name) as NSNumber)
            
            stepper.stepValue = Double(currentPrice)
            stepper.value = stepper.stepValue * Double((quantity))
            
            priceLabel.text = "\(currentPrice * Int(quantity))" + "uah"
            
        }else if sizeArr[row] == "1" {
            currentSize = 1
            currentPrice += 20
            
            priceLabel.text = "\(currentPrice * Int(quantity))" + "uah"
            
            stepper.stepValue = Double(currentPrice)
            stepper.value = stepper.stepValue * Double((quantity))
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sizeArr[row]
    }
}

extension DrinksPropertiesViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: mainView) == true {
            return false
        }
        return true
    }
}

//
//  SaladsIngridientsViewController.swift
//  veteranoPizzaIntegration
//
//  Created by User on 07.02.2022.
//

import Foundation
import UIKit

class SaladsIngredientsViewController: UIViewController {
    
    public var food: Food!
    var pizzaPrice30 = 0
    var addFoodbuttonAction: (() -> Void)?
    var currentPrice = 0
    var quantity = 1
    
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
        image.layer.cornerRadius = Size.width/5
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
        
        return button
    }()
    
    private lazy var foodWeight: UILabel = {
        let foodDescription = UILabel()
        foodDescription.textAlignment = .left
        foodDescription.numberOfLines = 0
//        foodDescription.adjustsFontSizeToFitWidth = true
//        foodDescription.minimumScaleFactor = 0.5
        foodDescription.font = FontFamily.Montserrat.semiBold.font(size: 12)
        return foodDescription
    }()
    
    private lazy var foodDescription: UILabel = {
        let foodDescription = UILabel()
        foodDescription.textAlignment = .left
        foodDescription.numberOfLines = 4
        foodDescription.adjustsFontSizeToFitWidth = true
        foodDescription.minimumScaleFactor = 0.5
        foodDescription.font = FontFamily.Montserrat.light.font(size: 12)
        return foodDescription
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
        //        quantityLabel.adjustsFontSizeToFitWidth = true
        //        quantityLabel.minimumScaleFactor = 0.5
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
        //        button.layer.masksToBounds = true
        button.setTitle("Додати в кошик", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.init(hexString:"#861901")
        button.titleLabel?.font = FontFamily.Montserrat.semiBold.font(size: 12.0)
        button.addTarget(self, action: #selector(addToBasketButtonPressed), for: .touchUpInside)
        
        return button
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
        view.text = "Не додавати до салату:"
        view.delegate = self
        
        return view
    }()
    
    func sendData(myData: Food) {
        self.food = myData
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .clear
        
        currentPrice = Int(truncating: PriceFactory.shared.returnSaladsValue(id: food.name) as NSNumber)
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
        foodDescription.text = food.description
        priceLabel.text = "\(currentPrice)" + "uah"
        
        stepper.stepValue = Double(currentPrice)
        stepper.value = stepper.stepValue
        
        quantity = Int(stepper.value / stepper.stepValue)
        
        foodWeight.text = "\(WeightFactory.shared.returnSaladsWeight(id: foodName.text!))"
        
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
            $0.size(.width(300/375*Size.width), .height(560/812*Size.heigth))
            $0.centerX.constraint(to: view, by: .centerX(0))
            $0.centerY.constraint(to: view, by: .centerY(0))
        }
        
        mainView.addSubview(foodImage)
        foodImage.layout {
            $0.constraint(to: mainView, by: .top(25))
            $0.size(.width(150/375*Size.width), .height(150/375*Size.width))
            $0.centerX.constraint(to: mainView, by: .centerX(0))
        }
        
        mainView.addSubview(backButton)
        backButton.layout {
            $0.constraint(to: mainView, by: .top(20), .leading(15))
            $0.size(.width(70/375*Size.width), .height(40/812*Size.heigth))
        }
        
        mainView.addSubview(foodName)
        foodName.layout {
            $0.constraint(to: mainView, by: .leading(15))
            $0.top.constraint(to: foodImage, by: .bottom(10))
            $0.size(.width(70/375*Size.width), .height(30/812*Size.heigth))
        }
        
        mainView.addSubview(foodDescription)
        foodDescription.layout {
            $0.constraint(to: mainView, by: .leading(15))
            $0.top.constraint(to: foodName, by: .bottom(5))
            $0.size(.width(300/375*Size.width), .height(50/812*Size.heigth))
        }
        
        mainView.addSubview(quantityLabel)
        quantityLabel.layout {
            $0.constraint(to: mainView, by: .leading(15))
            $0.top.constraint(to: foodDescription, by: .bottom(30))
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
            $0.bottom.constraint(to: stepper, by: .top(-5))
            $0.size(.width(20/375*Size.width), .height(20/812*Size.heigth))
        }
        
        mainView.addSubview(textView)
        textView.layout {
            $0.centerX.constraint(to: mainView, by: .centerX(0))
            $0.top.constraint(to: stepper, by: .bottom(15))
            $0.size(.width(276/375*Size.width), .height(50/812*Size.heigth))
        }
        
        
        mainView.addSubview(foodWeight)
        foodWeight.layout {
            $0.top.constraint(to: textView, by: .bottom(15))
            $0.constraint(to: mainView, by: .leading(15))
            $0.size(.width(80/375*Size.width), .height(20/812*Size.heigth))
        }
        
        mainView.addSubview(priceLabel)
        priceLabel.layout {
            $0.constraint(to: mainView, by: .leading(15), .bottom(-25))
            $0.size(.width(80/375*Size.width), .height(20/812*Size.heigth))
        }
        
        mainView.addSubview(addToBasketButton)
        addToBasketButton.layout {
            $0.trailing.constraint(to: mainView,by: .trailing(-15))
            $0.size(.width(120/375*Size.width), .height(60/812*Size.heigth))
            $0.centerY.constraint(to: priceLabel, by: .centerY(0))
        }
        
        self.foodImage.layer.masksToBounds = true
    }
    
    @objc func backButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func addToBasketButtonPressed() {
        if textView.text == "Не додавати до салату:" {
            OrderService.shared.addProduct(.init(food:self.food, quantity: Int(quantity), size: 0, price: currentPrice, removedIngridients: ""))
        }else {
            OrderService.shared.addProduct(.init(food:self.food, quantity: Int(quantity), size: 0, price: currentPrice, removedIngridients: textView.text ?? ""))
        }

        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func stepperChanged(_ sender: UIStepper) {
        quantity = Int(stepper.value / stepper.stepValue)
        countLabel.text = "\(Int(quantity))"
        priceLabel.text = "\(Int(sender.value))" + "uah"
    }
}

extension SaladsIngredientsViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: self.mainView) == true {
            return false
        }
        return true
    }
}

extension SaladsIngredientsViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty || textView.text == " " {
            textView.text = "Не додавати до салату:"
            textView.textColor = UIColor.lightGray
        }
    }
}

//
//  RootViewController.swift
//  veteranoPizzaIntegration
//
//  Created by User on 20.01.2022.
//

import UIKit

class PizzaViewController: UIViewController {
    
    let foodArr = VeteranoInfo.shared.getPizzaArr()
    
    private lazy var foodTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.separatorStyle = .singleLine
        tableView.isScrollEnabled = true
        tableView.backgroundColor = .white
        PizzaTableViewCell.register(for: tableView)
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.rightBarButtonItems![1].title = "\(OrderService.shared.productCount())"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationbar()
        setUp()
        setUpCity()
        setUpCityEnum()
        
        NotificationCenter.default.addObserver(self, selector: #selector(orderCounterDidUpdate), name: .init(OrderService.shared.orderServiceNotificationKey), object: nil)
    }
    
    private func setUp() {
        self.view.addSubview(foodTableView)
        foodTableView.layout {
            $0.constraint(to: self.view, by: .top(0), .bottom(0), .trailing(0), .leading(0))
        }
        foodTableView.layoutIfNeeded()
    }
    
    private func setUpNavigationbar() {
        applyDefaultNavigationBar()
        //        let rightLogo = Asset.shoppingCart.image
        //        let imageViewRight = UIImageView(image:rightLogo)
        //        self.navigationItem.titleView = imageViewRight
        let shoppingCartButton = UIBarButtonItem(image: Asset.shoppingCart.image,
                                                 style: .done,
                                                 target: self,
                                                 action: #selector(shoppingCartButtonTapped))
        shoppingCartButton.tintColor = .white
        let countFoodButton = UIBarButtonItem(image: nil,
                                              style: .done,
                                              target: self,
                                              action: #selector(countFoodButtonTapped))
        countFoodButton.title = "0"
        countFoodButton.tintColor = .white
//        countFoodButton.isEnabled = false
        
        navigationItem.rightBarButtonItems = [shoppingCartButton, countFoodButton]
        //        let appearance = UINavigationBarAppearance()
        //        appearance.backgroundColor = .black
        //        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        let backButton = UIBarButtonItem(image: Asset.backButton.image,
                                              style: .done,
                                              target: self,
                                              action: #selector(backButtonTapped))
        backButton.tintColor = .white
        
        navigationItem.leftBarButtonItem = backButton
        
    }
    
    func setUpCity() {
        
        let alert = UIAlertController(title: "Виберіть ваше місто", message: "", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Львів", style: UIAlertAction.Style.default, handler: { (action) in
            UserDefaults.standard.setValue("Львів", forKey: "ClientCity")
            UserDefaults.standard.synchronize()
        }))
        
        alert.addAction(UIAlertAction(title: "Стрий", style: UIAlertAction.Style.default, handler: { (action) in
            UserDefaults.standard.setValue("Стрий", forKey: "ClientCity")
            UserDefaults.standard.synchronize()
        }))
        
        alert.addAction(UIAlertAction(title: "Стебник, Трускавець, Дрогобич та Борислав", style: UIAlertAction.Style.default, handler: { (action) in
            UserDefaults.standard.setValue("Стебник, Трускавець, Дрогобич та Борислав", forKey: "ClientCity")
            UserDefaults.standard.synchronize()
            
        }))
        
        if (UserDefaults.standard.string(forKey: "ClientCity") == nil){
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func setUpCityEnum() {
        
        if ((UserDefaults.standard.string(forKey: "ClientCity") == "Львів")){
            PriceFactory.shared.location = Location.lviv
        }else if ((UserDefaults.standard.string(forKey: "ClientCity") == "Стрий")){
            PriceFactory.shared.location = Location.struy
        }else{
            PriceFactory.shared.location = Location.another
        }
    }
    
    @objc private func shoppingCartButtonTapped() {
                let preOrderViewController = PreOrderViewController()
                navigationController?.pushViewController(preOrderViewController, animated: true)
    }
    
    @objc private func countFoodButtonTapped() {
        //        let profileViewController = ProfileViewController()
        //        navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    @objc func orderCounterDidUpdate() {
        navigationItem.rightBarButtonItems![1].title = "\(OrderService.shared.productCount())"
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
}

extension PizzaViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = PizzaTableViewCell.deque(for: tableView, indexPath: indexPath) else {
            return UITableViewCell()
        }
        let selectedFood = foodArr[indexPath.row]
        cell.buttonAction = { [self] in
            let ingredientsViewController = PizzaIngredientsViewController()
            ingredientsViewController.food = selectedFood
            let navigationController = UINavigationController(rootViewController: ingredientsViewController)
            navigationController.modalTransitionStyle = .coverVertical
            navigationController.modalPresentationStyle = .overFullScreen

            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(50), execute: {
                present(navigationController, animated: true)
            })
            
        }
        cell.contentView.isUserInteractionEnabled = false
        cell.setUp(arr: selectedFood)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500/812*Size.heigth
    }
}

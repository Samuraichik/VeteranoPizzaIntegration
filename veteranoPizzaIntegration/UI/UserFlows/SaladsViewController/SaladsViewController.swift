//
//  SaladsViewController.swift
//  veteranoPizzaIntegration
//
//  Created by User on 07.02.2022.
//

import Foundation
import UIKit

class SaladsViewController: UIViewController {
    
    let foodArr = VeteranoInfo.shared.getSaladsArr()
    
    private lazy var foodTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.separatorStyle = .singleLine
        tableView.isScrollEnabled = true
        tableView.backgroundColor = .white
        SaladsTableViewCell.register(for: tableView)
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.rightBarButtonItems![1].title = "\(OrderService.shared.productCount())"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationbar()
        setUp()
        
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

extension SaladsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = SaladsTableViewCell.deque(for: tableView, indexPath: indexPath) else {
            return UITableViewCell()
        }
        let selectedFood = foodArr[indexPath.row]
        cell.buttonAction = { [self] in
            let ingredientsViewController = SaladsIngredientsViewController()
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

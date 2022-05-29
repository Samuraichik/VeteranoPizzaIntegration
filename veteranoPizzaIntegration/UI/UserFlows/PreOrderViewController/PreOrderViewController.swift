//
//  PreOrderViewController.swift
//  veteranoPizzaIntegration
//
//  Created by User on 03.02.2022.
//
import Foundation
import UIKit

class PreOrderViewController: UIViewController, DoubleDismissableViewController {
    
    public var onDismiss: (() -> Void)?
    
    private var products: [Product]!
    
    private lazy var servingFoodView: UIImageView = {
        let image = UIImageView()
        image.image = Asset.servingFoodIcon.image
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var foodTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.separatorStyle = .singleLine
        tableView.isScrollEnabled = true
        tableView.backgroundColor = .white
        PreOrderTableViewCell.register(for: tableView)
        return tableView
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton()
//        button.contentMode = .scaleAspectFit
        button.layer.cornerRadius = Size.width/19
//        button.layer.masksToBounds = true
        button.setTitle("Перейти до оплати", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.init(hexString:"#861901")
        button.titleLabel?.font = FontFamily.Montserrat.semiBold.font(size: 12.0)
        button.addTarget(self, action: #selector(continueButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var continueSurfingButton: UIButton = {
        let button = UIButton()
//        button.contentMode = .scaleAspectFit
//        button.clipsToBounds = true
        button.layer.cornerRadius = Size.width/19
//        button.layer.masksToBounds = true
        button.setTitle("Продовжити", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.lightGray
        button.titleLabel?.font = FontFamily.Montserrat.semiBold.font(size: 12.0)
        button.addTarget(self, action: #selector(continueSurfingButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: onDismiss)
    }
    
    @IBAction func payButton(_ sender: Any) {
        if OrderService.shared.productCount() == 0{
            //            let alert = UIAlertController(title: "Спочатку виберіть продукт", message: "", preferredStyle: UIAlertController.Style.alert)
            //            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil))
            //            self.present(alert, animated: true, completion: nil)
        }else{
            performSegue(withIdentifier: "OrderSettingsDisplay", sender: nil)
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if OrderService.shared.productCount() == 0 {
            foodTableView.isHidden = true
            servingFoodView.isHidden = false
        }else {
            foodTableView.isHidden = false
            servingFoodView.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.products = OrderService.shared.productArr()
        setUpNavBar()
        setUpViews()
        
    }
    
    private func setUpNavBar() {
        applyDefaultNavigationBar()
        let backButton = UIBarButtonItem(image: Asset.backButton.image,
                                         style: .done,
                                         target: self,
                                         action: #selector(backButtonButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        
        tabBarController?.tabBar.isHidden = true
    }
    private func setUpViews() {
        self.view.addSubview(servingFoodView)
        servingFoodView.layout {
            $0.centerY.constraint(to: self.view, by: .centerY(0))
            $0.centerX.constraint(to: self.view, by: .centerX(0))
            $0.size(.height(90/812*Size.heigth), .width(180/365*Size.width))
        }
        
        self.view.addSubview(foodTableView)
        foodTableView.layout {
            $0.constraint(to: view, by: .top(0),.bottom(-80), .trailing(0),.leading(0))
        }
        
        self.view.addSubview(continueButton)
        continueButton.layout {
            $0.constraint(to: view, by: .bottom(-15), .trailing(-10))
            $0.size(.height(50/812*Size.heigth), .width(130/365*Size.width))
        }
        
        self.view.addSubview(continueSurfingButton)
        continueSurfingButton.layout {
            $0.constraint(to: view, by:.bottom(-15), .leading(10))
            $0.size(.height(50/812*Size.heigth), .width(130/365*Size.width))
        }
    }
    
    @objc private func backButtonButtonTapped() {
        self.navigationController?.popViewController(animated: true)
        tabBarController?.tabBar.isHidden = false
    }
    
    
    
    @objc private func continueButtonPressed() {
        let orderVC = OrderViewController()
        navigationController?.pushViewController(orderVC, animated: true)
    }
    
    @objc private func continueSurfingButtonPressed() {
        navigationController?.popViewController(animated: true)
        tabBarController?.tabBar.isHidden = false
    }
    
}

extension PreOrderViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = PreOrderTableViewCell.deque(for: tableView, indexPath: indexPath) else {
            return UITableViewCell()
        }
        cell.contentView.isUserInteractionEnabled = false
        cell.setUp(product: products[indexPath.row])
    
        cell.buttonAction = { [self] in
            
            OrderService.shared.removeProduct(OrderService.shared.productArr()[indexPath.row], shouldRemoveCell:  { index in
                self.products = OrderService.shared.productArr()
                if let i = index {
                    foodTableView.beginUpdates()
                    foodTableView.deleteRows(at: [IndexPath.init(row: i, section: 0)], with: .automatic)
                    foodTableView.endUpdates()
                }else {
                    foodTableView.reloadData()
                }
            })
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150/812*Size.heigth
    }
}

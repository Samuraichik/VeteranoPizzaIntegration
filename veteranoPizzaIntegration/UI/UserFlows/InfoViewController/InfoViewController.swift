//
//  InfoViewController.swift
//  veteranoPizzaIntegration
//
//  Created by User on 05.02.2022.
//

import Foundation
import UIKit
import WebKit

class InfoViewController: UIViewController {
    
    private lazy var aboutUsButton: UIButton = {
        let button = UIButton()
//        button.contentMode = .scaleAspectFit
//        button.clipsToBounds = true
        button.layer.cornerRadius = Size.width/50
//        button.layer.masksToBounds = true
        button.setTitle("aboutUs", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.init(hexString:"#861901")
        button.titleLabel?.font = FontFamily.Montserrat.semiBold.font(size: 12.0)
        button.addTarget(self, action: #selector(aboutUsButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var politicConfidentionalButton: UIButton = {
        let button = UIButton()
//        button.contentMode = .scaleAspectFit
//        button.clipsToBounds = true
        button.layer.cornerRadius = Size.width/50
//        button.layer.masksToBounds = true
        button.setTitle("Oбрати", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.init(hexString:"#861901")
        button.titleLabel?.font = FontFamily.Montserrat.semiBold.font(size: 12.0)
        button.addTarget(self, action: #selector(politicConfidentionalButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var publicContractButton: UIButton = {
        let button = UIButton()
//        button.contentMode = .scaleAspectFit
//        button.clipsToBounds = true
        button.layer.cornerRadius = Size.width/50
//        button.layer.masksToBounds = true
        button.setTitle("Oбрати", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.init(hexString:"#861901")
        button.titleLabel?.font = FontFamily.Montserrat.semiBold.font(size: 12.0)
        button.addTarget(self, action: #selector(publicContractButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var contactsButton: UIButton = {
        let button = UIButton()
//        button.contentMode = .scaleAspectFit
//        button.clipsToBounds = true
        button.layer.cornerRadius = Size.width/50
//        button.layer.masksToBounds = true
        button.setTitle("Oбрати", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.init(hexString:"#861901")
        button.titleLabel?.font = FontFamily.Montserrat.semiBold.font(size: 12.0)
        button.addTarget(self, action: #selector(contactsButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    @IBOutlet weak var imageView: UIImageView!
    var url: String!
    
    @IBAction func instargramButton(_ sender: Any) {
        url = "https://www.instagram.com/veteranopizza.lviv/"
        performSegue(withIdentifier: "webControllerSegue", sender: nil)
    }
    @IBAction func facebookButton(_ sender: Any) {
        url = "https://www.facebook.com/veteranopizza.lviv"
        performSegue(withIdentifier: "webControllerSegue", sender: nil)
    }
    @IBOutlet weak var changeCityButton: UIBarButtonItem!
    
    @IBAction func changeCityButton(_ sender: Any) {
        let alert = UIAlertController(title: "Виберіть ваше місто", message: "", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Львів", style:
                                        UIAlertAction.Style.default, handler: { (action) in
                                            
            UserDefaults.standard.setValue("Львів", forKey: "ClientCity")
            UserDefaults.standard.synchronize()
            PriceFactory.shared.location = Location.lviv
        }))
        alert.addAction(UIAlertAction(title: "Стрий", style: UIAlertAction.Style.default, handler: { (action) in
            UserDefaults.standard.setValue("Стрий", forKey: "ClientCity")
            UserDefaults.standard.synchronize()
            PriceFactory.shared.location = Location.struy
        }))
        
        alert.addAction(UIAlertAction(title: "Стебник, Трускавець, Дрогобич та Борислав", style: UIAlertAction.Style.default, handler: { (action) in
            UserDefaults.standard.setValue("Стебник, Трускавець, Дрогобич та Борислав", forKey: "ClientCity")
            UserDefaults.standard.synchronize()
            PriceFactory.shared.location = Location.another
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func politicConfidentionalButton(_ sender: Any) {
        
        performSegue(withIdentifier: "PoliticConfidentionalViewControllerSegue", sender: nil)
    }
    
    @IBAction func aboutUsButton(_ sender: Any) {
        performSegue(withIdentifier: "AboutUsControllerSegue", sender: nil)
    }
    
    @IBAction func publicContractButton(_ sender: Any) {
        performSegue(withIdentifier: "PublicContractViewControllerSegue", sender: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationItem.rightBarButtonItems![1].title = "\(OrderService.shared.productCount())"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setUpNavigationbar()
        setUpViews()

        NotificationCenter.default.addObserver(self, selector: #selector(orderCounterDidUpdate), name: .init(OrderService.shared.orderServiceNotificationKey), object: nil)

    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let desctinationVC: WebViewController = segue.destination as! WebViewController
//        desctinationVC.url1 = self.url
//    }
    
    private func setUpNavigationbar() {
//        applyDefaultNavigationBar()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.tintColor = .white
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
        
    }
    
    private func setUpViews() {
        self.view.addSubview(aboutUsButton)
        aboutUsButton.layout {
            $0.size(.width(350/375*Size.width), .height(100/812*Size.heigth))
            $0.centerX.constraint(to: view, by: .centerX(0))
            $0.centerY.constraint(to: view, by: .centerY(0))
        }
        
//
//        mainView.addSubview(foodImage)
//        foodImage.layout {
//            $0.constraint(to: mainView, by: .top(25))
//            $0.size(.width(150/375*Size.width), .height(150/375*Size.width))
//            $0.centerX.constraint(to: mainView, by: .centerX(0))
//        }
        
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
    
    @objc func aboutUsButtonPressed() {
        let openLibrariesViewController = OpenLibrariesViewController()
        navigationController?.pushViewController(openLibrariesViewController, animated: true)
    }
    
    @objc func politicConfidentionalButtonPressed() {

    }
    
    @objc func publicContractButtonPressed() {

    }
    
    @objc func contactsButtonPressed() {

    }
}

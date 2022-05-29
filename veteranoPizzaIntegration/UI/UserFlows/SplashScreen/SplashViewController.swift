//
//  SplashViewController.swift
//  veteranoPizzaIntegration
//
//  Created by User on 20.01.2022.
//
import UIKit
import Foundation

class SplashViewController: UIViewController {
    private lazy var itemImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.image = Asset.veteranoLabelLaunch.image
        return iconImageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setUpUI()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            self.performNeededSegue()
        })
    }
    
    private func setUpUI() {
        view.backgroundColor = Palette.background01
        
        view.addSubview(itemImageView)
        itemImageView.layout {
            $0.centerX.constraint(to: view, by: .centerX(0))
            $0.centerY.constraint(to: view, by: .centerY(0))
            $0.size(.width(Size.width * 257 / 375))
        }
    }
    
    private func performNeededSegue() {
        //        if AuthService.shared.authType == .notAuthorized {
        //            let onboardingVc = OnboardingViewController()
        //            onboardingVc.modalTransitionStyle = .crossDissolve
        //            onboardingVc.modalPresentationStyle = .overFullScreen
        //            present(onboardingVc, animated: true, completion: nil)
        //        } else {
        //            if let vc = UIStoryboard(name: "Home", bundle: nil).instantiateInitialViewController() {
        //                vc.modalTransitionStyle = .crossDissolve
        //                vc.modalPresentationStyle = .overFullScreen
        //                present(vc, animated: true, completion: nil)
        //            }
        //        }
        //    }
        
//        let rootViewController =
//        let navigationController =
//        
        let tabBarVC = UITabBarController()
        let rootVC = UINavigationController(rootViewController: RootCollectionViewController())
        let promoVC = UINavigationController(rootViewController: PromoViewController())
        let infoVC = UINavigationController(rootViewController: InfoViewController())
        tabBarVC.setViewControllers([rootVC,promoVC,infoVC], animated: true)
        
        guard let items = tabBarVC.tabBar.items else {
            return
        }
        
        let images = [Asset.tabBarHomeItem.image, Asset.tabBarPromoImage.image, Asset.tabBarInfoImage.image] as [Any]
        
        for i in 0..<items.count {
            items[i].image = images[i] as? UIImage
        }
        
        tabBarVC.tabBar.clipsToBounds = true
        tabBarVC.tabBar.tintColor =  UIColor.init(hexString:"#861901")
        tabBarVC.tabBar.backgroundColor = .white
        tabBarVC.modalTransitionStyle = .crossDissolve
        tabBarVC.modalPresentationStyle = .overFullScreen
        present(tabBarVC, animated: true, completion: nil)
        
        
        
        
        //                    if let vc = UIStoryboard(name: "RootViewController", bundle: nil).instantiateInitialViewController() {
        //                        vc.modalTransitionStyle = .crossDissolve
        //                        vc.modalPresentationStyle = .overFullScreen
        //                        present(vc, animated: true, completion: nil)
        
//        let rootViewController = RootCollectionViewController()
//        let navigationController = UINavigationController(rootViewController: rootViewController)
//        navigationController.modalTransitionStyle = .crossDissolve
//        navigationController.modalPresentationStyle = .overFullScreen
//        present(navigationController, animated: true)
    }
}


//
//  UIVIewController.swift
//  veteranoPizzaIntegration
//
//  Created by User on 20.01.2022.
//

import Foundation
import UIKit

extension UIViewController {
    
    // MARK: - Navigation Bar SetUp
    func applyDefaultNavigationBar() {
//        navigationItem.backBarButtonItem = UIBarButtonItem.customBackButton
        
        guard let navVc = (self as? UINavigationController) ?? navigationController else {return}
        navVc.navigationBar.isTranslucent = false
        navVc.navigationBar.barTintColor = .black
        navVc.navigationBar.tintColor = .white
//        navVc.navigationBar.setBackgroundImage(Asset.navigationBarBackground.image, for: .default)
//        navVc.navigationBar.backgroundColor = .black
        
//        navVc.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : Palette.text01]
//        navVc.navigationBar.shadowImage = UIImage()
    }
}

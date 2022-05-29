//
//  DoubleDismiss.swift
//  veteranoPizzaIntegration
//
//  Created by User on 02.02.2022.
//

import Foundation
import UIKit

protocol DoubleDismissableViewController: UIViewController {
    var onDismiss: (() -> Void)? { get set }
}

extension UIViewController {
    func addDoubleDismiss(for segue: UIStoryboardSegue) {
        if let vc = (segue.destination as? DoubleDismissableViewController)
            ?? (segue.destination as? UINavigationController)?.viewControllers.first as? DoubleDismissableViewController {
            vc.onDismiss = {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}

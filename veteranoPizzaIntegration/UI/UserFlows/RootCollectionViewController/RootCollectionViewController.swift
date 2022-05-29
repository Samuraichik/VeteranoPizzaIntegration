//
//  RootCollectionViewController.swift
//  veteranoPizzaIntegration
//
//  Created by User on 04.02.2022.
//

import Foundation
import UIKit

class RootCollectionViewController: UIViewController, DoubleDismissableViewController {
    
    public var onDismiss: (() -> Void)?
    let simpleOver = SimpleOver()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var pizzaView: UIImageView = {
        let view = UIImageView()
        view.image = Asset.pizzaViewImage.image
        view.layer.cornerRadius = 30
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.init(hexString:"#861901").cgColor
        let tap = UITapGestureRecognizer(target: self, action: #selector(pizzaViewDidTap))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private lazy var pizzaLabel: UILabel = {
        let label = UILabel()
        label.text = "Піца"
        label.textAlignment = .right
        label.textColor = .white
        label.font = FontFamily.Montserrat.bold.font(size: 17)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private lazy var saladsView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 30
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.init(hexString:"#861901").cgColor
        view.image = Asset.saladsViewImage.image
        let tap = UITapGestureRecognizer(target: self, action: #selector(saladsViewDidTap))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private lazy var saladsLabel: UILabel = {
        let label = UILabel()
        label.text = "Салати"
        label.textAlignment = .right
        label.textColor = .white
        label.font = FontFamily.Montserrat.bold.font(size: 17)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private lazy var dessertsView: UIImageView = {
        let view = UIImageView()
        view.image = Asset.dessertsViewImage.image
        view.layer.cornerRadius = 30
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.init(hexString:"#861901").cgColor
        let tap = UITapGestureRecognizer(target: self, action: #selector(dessertsViewDidTap))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    private lazy var dessertsLabel: UILabel = {
        let label = UILabel()
        label.text = "Десерти"
        label.textAlignment = .right
        label.textColor = .white
        label.font = FontFamily.Montserrat.bold.font(size: 17)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private lazy var soucesView: UIImageView = {
        let view = UIImageView()
        view.image = Asset.soucesViewImage.image
        view.layer.cornerRadius = 30
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.init(hexString:"#861901").cgColor
        let tap = UITapGestureRecognizer(target: self, action: #selector(soucesViewDidTap))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private lazy var soucesLabel: UILabel = {
        let label = UILabel()
        label.text = "Соуси"
        label.textAlignment = .right
        label.textColor = .white
        label.font = FontFamily.Montserrat.bold.font(size: 17)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private lazy var drinksView: UIImageView = {
        let view = UIImageView()
        view.image = Asset.drinksViewImage.image
        view.layer.cornerRadius = 30
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.init(hexString:"#861901").cgColor
        let tap = UITapGestureRecognizer(target: self, action: #selector(drinksViewDidTap))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private lazy var drinksLabel: UILabel = {
        let label = UILabel()
        label.text = "Напої"
        label.textAlignment = .right
        label.textColor = .white
        label.font = FontFamily.Montserrat.bold.font(size: 17)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    var additionalPrice: Int!
    var foodOptions = [Option]()
    var ingredientsArr: [String]?
    
    override func viewWillAppear(_ animated: Bool) {
        //        collectionView.reloadData()
        navigationItem.rightBarButtonItems![1].title = "\(OrderService.shared.productCount())"
    }
    
    override func viewDidLoad() {
        additionalPrice = 0
        self.view.backgroundColor = .white
        setUpNavBar()
        setUp()
        setUpViews()
        setUpIngredientsArr()
        
        NotificationCenter.default.addObserver(self, selector: #selector(orderCounterDidUpdate), name: .init(OrderService.shared.orderServiceNotificationKey), object: nil)
        navigationController?.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    private func setUpIngredientsArr() {
    }
    
    private func setUpNavBar() {
        applyDefaultNavigationBar()
        
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
    }
    
    private func setUp() {
        self.pizzaView.layer.masksToBounds = true
        self.saladsView.layer.masksToBounds = true
        self.drinksView.layer.masksToBounds = true
        self.soucesView.layer.masksToBounds = true
        self.dessertsView.layer.masksToBounds = true
    }
    
    private func setUpViews() {
        
        view.addSubview(contentView)
        contentView.layout {
            $0.constraint(to: view, by: .trailing(-20), .leading(20), .top(40), .bottom(-100))
        }
        
        contentView.addSubview(pizzaView)
        pizzaView.layout {
            $0.constraint(to: contentView, by: .top(10), .trailing(0), .leading(0))
            $0.size(.height(150/812*Size.heigth))
            $0.centerX.constraint(to: contentView, by: .centerX(0))
        }
        
        pizzaView.addSubview(pizzaLabel)
        pizzaLabel.layout {
            $0.constraint(to: pizzaView, by: .bottom(-10), .trailing(-10))
            $0.size(.height(30/812*Size.heigth), .width(100/375*Size.width))
        }
        
        contentView.addSubview(saladsView)
        saladsView.layout {
            $0.top.constraint(to: pizzaView, by: .bottom(20))
            $0.size(.width(160/375*Size.width), .height(160/812*Size.heigth))
            $0.constraint(to: contentView, by: .leading(0))
        }
        
        saladsView.addSubview(saladsLabel)
        saladsLabel.layout {
            $0.constraint(to: saladsView, by: .bottom(-10), .trailing(-10))
            $0.size(.height(30/812*Size.heigth), .width(100/375*Size.width))
        }
        
        contentView.addSubview(dessertsView)
        dessertsView.layout {
            $0.top.constraint(to: pizzaView, by: .bottom(20))
            $0.size(.width(160/375*Size.width), .height(160/812*Size.heigth))
            $0.constraint(to: contentView, by: .trailing(0))
        }
        
        dessertsView.addSubview(dessertsLabel)
        dessertsLabel.layout {
            $0.constraint(to: dessertsView, by: .bottom(-10), .trailing(-10))
            $0.size(.height(30/812*Size.heigth), .width(100/375*Size.width))
        }
        
        contentView.addSubview(drinksView)
        drinksView.layout {
            $0.top.constraint(to: saladsView, by: .bottom(20))
            $0.size(.width(160/375*Size.width), .height(160/812*Size.heigth))
            $0.constraint(to: contentView, by: .leading(0))
        }
        
        drinksView.addSubview(drinksLabel)
        drinksLabel.layout {
            $0.constraint(to: drinksView, by: .bottom(-10), .trailing(-10))
            $0.size(.height(30/812*Size.heigth), .width(100/375*Size.width))
        }
        
        contentView.addSubview(soucesView)
        soucesView.layout {
            $0.top.constraint(to: dessertsView, by: .bottom(20))
            $0.size(.width(160/375*Size.width), .height(160/812*Size.heigth))
            $0.constraint(to: contentView, by: .trailing(0))
        }
        
        soucesView.addSubview(soucesLabel)
        soucesLabel.layout {
            $0.constraint(to: soucesView, by: .bottom(-10), .trailing(-10))
            $0.size(.height(30/812*Size.heigth), .width(100/375*Size.width))
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
    
    @objc private func backButtonButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func pizzaViewDidTap() {
        //        UIImageView.animate(withDuration: 0.6,
        //                            animations: {
        //            self.pizzaView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        //        },
        //                            completion: { _ in
        //            UIImageView.animate(withDuration: 0.6) {
        //                self.pizzaView.transform = CGAffineTransform.identity
        //            }
        //        })
        let pizzaVC = PizzaViewController()
        self.navigationController?.pushViewController(pizzaVC, animated: true)
        //        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100), execute: {
        //
        //
        //        })
        //
        //
    }
    
    @objc func orderCounterDidUpdate() {
        navigationItem.rightBarButtonItems![1].title = "\(OrderService.shared.productCount())"
    }
    
    @objc private  func saladsViewDidTap() {
        let saladsVC = SaladsViewController()
        navigationController?.pushViewController(saladsVC, animated: true)
    }
    
    @objc private func dessertsViewDidTap() {
        
    }
    
    @objc private func soucesViewDidTap() {
        let soucesVC = SoucesViewController()
        navigationController?.pushViewController(soucesVC, animated: true)
    }
    
    @objc private func drinksViewDidTap() {
        let drinksVC = DrinksRootViewController()
        navigationController?.pushViewController(drinksVC, animated: true)
    }
}

extension RootCollectionViewController: UIGestureRecognizerDelegate {
    
}


class SimpleOver: NSObject, UIViewControllerAnimatedTransitioning {
    
    var popStyle: Bool = false
    
    func transitionDuration(
        using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
            return 0.20
        }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        if popStyle {
            
            animatePop(using: transitionContext)
            return
        }
        
        let fz = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let tz = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        
        let f = transitionContext.finalFrame(for: tz)
        
        let fOff = f.offsetBy(dx: f.width, dy: 55)
        tz.view.frame = fOff
        
        transitionContext.containerView.insertSubview(tz.view, aboveSubview: fz.view)
        
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                tz.view.frame = f
            }, completion: {_ in
                transitionContext.completeTransition(true)
            })
    }
    
    func animatePop(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fz = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let tz = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        
        let f = transitionContext.initialFrame(for: fz)
        let fOffPop = f.offsetBy(dx: f.width, dy: 55)
        
        transitionContext.containerView.insertSubview(tz.view, belowSubview: fz.view)
        
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                fz.view.frame = fOffPop
            }, completion: {_ in
                transitionContext.completeTransition(true)
            })
    }
}

extension RootCollectionViewController: UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    
    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            
            self.simpleOver.popStyle = (operation == .pop)
            return self.simpleOver
        }
}

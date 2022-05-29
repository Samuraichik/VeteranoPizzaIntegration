////
////  PaymentController.swift
////  VeteranoPizza
////
////  Created by User on 28.08.2021.
////
////
//import Foundation
//import UIKit
//
//struct PaymentParams {
//    var version: Int
//    var orderId: String
//    var amount: Decimal
//    var description: String
//
//    func getAsLiqpayParams(forKey: String) -> [String: Any] {
//        return [
//            "action": "pay",
//            "version": version,
//            "order_id": orderId,
//            "public_key": forKey,
//            "amount": amount,
//            "currency": "UAH",
//            "description": description
//        ]
//    }
//}
//
//class LiqPayManager: NSObject {
//
//    private let privatKey = "sandbox_fmO3sBK3sfT9Z6GZBH5DUgHuYzHn6yfHt5i7Iz14"
//    private let publicKey = "sandbox_i16211328911"
//
//    private let navController: UINavigationController
//    private let statusBarColor: UIColor
//
//    private var paymentParameters: [AnyHashable : Any] {
//        // test payment
//        return [
//            "action": "pay",
//            "version": 3,
//            "order_id": "43",
//            "public_key": publicKey,
//            "amount": 32000,
//            "currency": "UAH",
//            "description": "iPhone 11 Pro 64GB"
//        ]
//    }
//
//    lazy var liqpayMob: L = {
//        return LiqpayMob(liqPayWithDelegate: self)
//    }()
//
//    init(navController: UINavigationController,
//         statusBarColor: UIColor) {
//        self.navController = navController
//        self.statusBarColor = statusBarColor
//    }
//
//    func pay(params: PaymentParams) {
//        liqpayMob.checkout(
//            params.getAsLiqpayParams(forKey: publicKey),
//            privateKey: privatKey,
//            delegate: self)
//    }
//
//}
//
//extension LiqPayManager: LiqPayCallBack {
//    func navigationController() -> UINavigationController! {
//        return navController
//    }
//
//    func onResponseSuccess(_ response: String!) {
//        print("response:", response ?? "-")
//    }
//
//    func onResponseError(_ errorCode: Error!) {
//        print("error:", errorCode ?? "-")
//    }
//
//    func getStatusBarColor() -> UIColor! {
//        return statusBarColor
//    }
//}

//
//  OrderService.swift
//  veteranoPizzaIntegration
//
//  Created by User on 30.01.2022.
//

import Foundation

class Product {
    var food: Food
    var quantity: Int
    var size: Decimal
    var price: Int
    var romovedIngrodients: String?
    
    init(food: Food, quantity: Int, size: Decimal, price: Int, removedIngridients: String?){
        self.food = food
        self.quantity = quantity
        self.size = size
        self.price = price
        self.romovedIngrodients = removedIngridients
    }
}

class OrderService {
    
    static let shared = OrderService()
    var orderServiceNotificationKey = "OrderService.notification.key"

    
    var a = 0
    private var products: [Product] = []
    
    public func addProduct(_ food: Product) {
        let matches = products.filter { (product) -> Bool in
            return product.food.name == food.food.name
        }
        if let matching = matches.first {
            matching.quantity += 1
        }else{
            products.append(food)
        }
        
        NotificationCenter.default.post(.init(name: .init(orderServiceNotificationKey)))
    }
    
    public func removeProduct(_ food: Product, shouldRemoveCell: ((Int?) -> Void)?) {
        
        let matches = products.firstIndex {(product) -> Bool in
            return product.food.name == food.food.name
        }
        
        if let matching = matches {
            if products[matching].quantity > 1 {
                products[matching].quantity -= 1
                shouldRemoveCell?(products.firstIndex(where: {$0 === food}))
            }else{
                products.remove(at: matching)
                shouldRemoveCell?(nil)
            }
        }
        
    }
    
    public func productCount() -> Int {
        return products.count
    }
    
    public func placeOrder() {}
    
    public func productArr() -> [Product] {
        return products
    }
}

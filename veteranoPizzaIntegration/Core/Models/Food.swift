//
//  Food.swift
//  veteranoPizzaIntegration
//
//  Created by User on 28.01.2022.
//
import Foundation
import UIKit

class Option: Codable {
    var price: Decimal
    var title: String
    init(price: Decimal, title: String) {
        self.price = price
        self.title = title
    }
}

class NewFood: Codable {
    var imageUrl: String
    var name: String
    var description: String
    var options: [Option]
}

struct Food {
    var image: UIImage?
    var name: String
    var description: String
    var options: [Option] = []
}

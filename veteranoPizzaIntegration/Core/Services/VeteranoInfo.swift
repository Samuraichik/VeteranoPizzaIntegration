//
//  VeteranoInfo.swift
//  veteranoPizzaIntegration
//
//  Created by User on 05.02.2022.
//

import Foundation
import UIKit

public class VeteranoInfo {
    
    static let shared = VeteranoInfo()
    
    private var drinksArr = [ Food(image: UIImage(named: "coca"),  name:"Кока Кола", description: ""),
            Food(image: UIImage(named: "coca") , name:"Кока Кола", description: ""),
            Food(image: UIImage(named: "coca"), name:"Кока Кола" , description: ""),
            Food(image: UIImage(named: "coca"), name:"Кока Кола", description: ""),
            Food(image: UIImage(named: "coca"), name:"Кока Кола", description: ""),
            Food(image: UIImage(named: "coca"), name:"Кока Кола", description: ""),
            Food(image: UIImage(named: "coca"), name:"Кока Кола", description: "") ]
    
    private var soucesArr = [ Food(image: UIImage(named: "соусЦезар"),  name:"Соус Цезар", description: "")]
    
    private let pizzaArr = [ Food(image: Asset.desertnaPizza.image,  name:"Десертна", description: "Вершки, маскарпоне, банан, груша, полуниця(інші сезонні ягоди чи фрукти), шоколадний топінг."),
                            Food(image: Asset.desertnaPizza.image, name:"Чілі-Манго", description: "Вершкова основа, моцарела, італійське м'ясо Di Parma, пармезан, соус манго-чілі."),
                            Food(image: Asset.desertnaPizza.image, name:"Капрезе" , description: "Вершкова основа, моцарела, помідори черрі, в‘ялені томати, соус Песто."),
                            Food(image: Asset.desertnaPizza.image, name:"Мисливська", description: "Томатна основа, моцарела, мисливськi ковбаски, печерицi, пармезан."),
                            Food(image: Asset.desertnaPizza.image, name:"Вегетеріана", description: "Томатна основа, помiдори, прованськi трави, рукола, печерицi,в‘ялені томати, оливки, соус Песто."),
                            Food(image: Asset.desertnaPizza.image, name:"Тірольська", description: "Томатна основа, моцарела, мисливські ковбаски, салямі, корнішони, перець гострий."),
                            Food(image: Asset.desertnaPizza.image, name:"Цезар", description: "Вершки, сир моцарела, запечене філе курки, бекон, чері, мікс салатів, соус цезар, пармезан.") ]
    
    private let saladsArr = [ Food(image: Asset.cesar.image,  name:"Di Parma", description: "Листя салату мікс, прошуто, Чері, гірчично-медовий соус, пармезан."),
                              Food(image: Asset.cesar.image, name:"Цезар", description: "Листя салату мікс, куряче філе, бекон, помідор чері, соус цезар, пармезан.")]
    
    private let promoArr = [ Food(image: Asset.promoTableViewImage.image,  name:"Будні без обмежень", description: "Чотири сири Ø 30 см, М'ясна Ø 30 см, Кватро Стаджоні Ø 30 см, Одуванчик Ø 30 см, Для Буслаєва Ø 30 см, Coca-cola, 1 л."),
                              Food(image: Asset.promoTableViewImage.image, name:"Третя ціль", description: "Чотири сири Ø 30 см, М'ясна Ø 30 см, Кватро Стаджоні Ø 30 см, Coca-cola, Fanta, Sprite по 0,5 л.")]
    
    var ingridientNames = [ "Ананас",  "Бекон",  "Горгонзола",  "Ікра",  "Лосось",  "Оливки",  "Пармезан",  "Печериці", "Помідор",  "Помідори чері",  "Рікота",  "Прошуто", "Рукола", "Салямі",  "Салямі Picanto",  "Куряче Філе",  "Шинка", "Extra сир" ]
    
    func getIngridientArr() -> [String]{
        return self.ingridientNames
    }
    
    func getSaladsArr() -> [Food]{
        return self.saladsArr
    }
    
    func getDrinksArr() -> [Food]{
        return self.drinksArr
    }
    
    func getSoucesArr() -> [Food]{
        return self.soucesArr
    }
    
    
    func getPizzaArr() -> [Food]{
        return self.pizzaArr
    }
    
    func getPromoArr() -> [Food]{
        return self.promoArr
    }
}

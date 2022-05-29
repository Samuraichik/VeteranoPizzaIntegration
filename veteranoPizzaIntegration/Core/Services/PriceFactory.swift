//
//  PriceFactory.swift
//  veteranoPizzaIntegration
//
//  Created by User on 28.01.2022.
//
import Foundation

let struyPizzaPrice: [String: Decimal] = ["Десертна": 170, "Чілі-Манго": 22, "Капрезе": 30,"Мисливська": 12,"Вегетеріана": 4,"Тірольська":12,"Цезар":42, "Пепсі": 20]
let lvivPizzaPrice:  [String: Decimal] = ["Десертна": 1250, "Чілі-Манго": 262, "Капрезе": 360,"Мисливська": 122,"Вегетеріана": 46,"Тірольська":612,"Цезар":42, "Пепсі": 2350]
let anotherPizzaPrice : [String: Decimal] = ["Десертна": 170, "Чілі-Манго": 22, "Капрезе": 30,"Мисливська": 12,"Вегетеріана": 4,"Тірольська":12,"Цезар":42, "Пепсі": 20]

let struySaladsPrice: [String: Decimal] = ["Di Parma": 170, "Цезар": 22]
let lvivSaladsPrice:  [String: Decimal] = ["Di Parma": 1250, "Цезар": 262]
let anotherSaladsPrice : [String: Decimal] = ["Di Parma": 170, "Цезар": 22]

let struyDrinksPrice: [String: Decimal] = ["Кока Кола": 40]
let lvivDrinksPrice:  [String: Decimal] = ["Кока Кола": 402]
let anotherDrinksPrice : [String: Decimal] = ["Кока Кола": 40]

let struySoucesPrice: [String: Decimal] = ["Соус Цезар": 40]
let lvivSoucesPrice:  [String: Decimal] = ["Соус Цезар": 402]
let anotherSoucesPrice : [String: Decimal] = ["Соус Цезар": 40]

let struyPromoPrice: [String: Decimal] = ["Будні без обмежень": 40, "Третя ціль": 40  ]
let lvivPromoPrice:  [String: Decimal] = ["Будні без обмежень": 402, "Третя ціль": 40  ]
let anotherPromoPrice : [String: Decimal] = ["Будні без обмежень": 40, "Третя ціль": 40  ]

let struyIngridientsPrice: [String: Decimal] = ["Ананас": 170, "Бекон": 22, "Горгонзола": 30,"Ікра": 12,"Лосось": 4,"Оливки":12,"Пармезан":42, "Печериці": 20, "Помідор": 40, "Помідори чері": 30,"Рікота": 12,"Прошуто": 4,"Рукола":12,"Салямі":42, "Салямі Picanto": 20, "Куряче Філе": 40, "Шинка":12,"Extra сир":42]

let lvivIngridientsPrice: [String: Decimal] = ["Ананас": 170, "Бекон": 22, "Горгонзола": 30,"Ікра": 12,"Лосось": 4,"Оливки":12,"Пармезан":42, "Печериці": 20, "Помідор": 40, "Помідори чері": 30,"Рікота": 12,"Прошуто": 4,"Рукола":12,"Салямі":42, "Салямі Picanto": 20, "Куряче Філе": 40, "Шинка":12,"Extra сир":42]

let anotherIngridientsPrice: [String: Decimal] = ["Ананас": 170, "Бекон": 22, "Горгонзола": 30,"Ікра": 12,"Лосось": 4,"Оливки":12,"Пармезан":42, "Печериці": 20, "Помідор": 40, "Помідори чері": 30,"Рікота": 12,"Прошуто": 4,"Рукола":12,"Салямі":42, "Салямі Picanto": 20, "Куряче Філе": 40, "Шинка":12,"Extra сир":42]



 class PriceFactory {
    
    static let shared = PriceFactory()
    public var location: Location!

     public func returnFoodValue(id: String) -> Decimal {
         return lvivPizzaPrice[id]!
         
//         switch location {
//         case .lviv:
//             return lvivPrice[id] ?? 0
//         case .struy:
//             return struyPrice[id] ?? 0
//         case .another:
//             return anotherPrice[id] ?? 0
//         default:
//             return 0
//         }
     }
     
     public func returnDrinksValue(id: String) -> Decimal {
         return lvivDrinksPrice[id]!
         
//         switch location {
//         case .lviv:
//             return lvivPrice[id] ?? 0
//         case .struy:
//             return struyPrice[id] ?? 0
//         case .another:
//             return anotherPrice[id] ?? 0
//         default:
//             return 0
//         }
     }
     
     public func returnIngridientsValue(id: String) -> Decimal {
         return lvivIngridientsPrice[id]!
         
//         switch location {
//         case .lviv:
//             return lvivPrice[id] ?? 0
//         case .struy:
//             return struyPrice[id] ?? 0
//         case .another:
//             return anotherPrice[id] ?? 0
//         default:
//             return 0
//         }
     }
     
     public func returnSaladsValue(id: String) -> Decimal {
         return lvivSaladsPrice[id]!
         
//         switch location {
//         case .lviv:
//             return lvivPrice[id] ?? 0
//         case .struy:
//             return struyPrice[id] ?? 0
//         case .another:
//             return anotherPrice[id] ?? 0
//         default:
//             return 0
//         }
     }
     
     public func returnSoucesValue(id: String) -> Decimal {
         return lvivSoucesPrice[id]!
         
//         switch location {
//         case .lviv:
//             return lvivPrice[id] ?? 0
//         case .struy:
//             return struyPrice[id] ?? 0
//         case .another:
//             return anotherPrice[id] ?? 0
//         default:
//             return 0
//         }
     }
     
     public func returnPromoValue(id: String) -> Decimal {
         return lvivPromoPrice[id]!
         
//         switch location {
//         case .lviv:
//             return lvivPrice[id] ?? 0
//         case .struy:
//             return struyPrice[id] ?? 0
//         case .another:
//             return anotherPrice[id] ?? 0
//         default:
//             return 0
//         }
     }
}

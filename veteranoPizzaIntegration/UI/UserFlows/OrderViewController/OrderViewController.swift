//
//  OrderViewController.swift
//  veteranoPizzaIntegration
//
//  Created by User on 06.02.2022.
//

import Foundation
import UIKit

class Order {
    var name: [String]?
    var title: String?
    
    init(title: String, name: [String]) {
        self.name = name
        self.title = title
    }
}

class OrderViewController: UIViewController {
    
    private lazy var infoTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .singleLine
        tableView.isScrollEnabled = true
        tableView.backgroundColor = .white
        tableView.allowsSelection = true
//        tableView.isUserInteractionEnabled = true
        OrderSettingsCell.register(for: tableView)
        BasketPizzaCells.register(for: tableView)
        DestinationCells.register(for: tableView)
        InfoFieldCells.register(for: tableView)
        ConfirmOrderCell.register(for: tableView)
        return tableView
    }()
    
    var destinationCellsInfo = ["Адресна доставка по Львову (безкоштовно)", "Самовивіз у Львові (безкоштовно)"]
    var destinationCellsDescription = ["Мінімальна сума замовлення для доставка 300 грн. Обмеження діють до покращення погодних умов.", "Працюємо з 11:00 до 23:00."]
    var destinationCellsIcons = ["icons8-круг-35 пустий", "icons8-круг-35"]
    var foodArr = OrderService.shared.productArr()
    var cellsArr: [Order] = [Order.init(title: "Кошик", name: ["sdsdff", "sdfsfdsf"]), Order.init(title: "dsdfsf", name: ["sdsff"]), Order.init(title: "dssdf", name: ["sdsdf"]), Order.init(title: "dsfgf", name: ["sdffsd"]), Order.init(title: "dsaf", name: ["sdsdf"]), Order.init(title: "dgdfsf", name: ["sdfd"])]
    var titles = ["Кошик", "Куди доставити замовлення?", "Способи оплати", "Контактні дані", "Оформити замовлення"]
    var payMethod = [" Оплата карткою ", "Оплата кур'єру"]
    var payMethodDesription = [" LIQPAY >>", ""]
    var contactsInfoLabels = ["Ім'я","Номер Телефону","Email","Адреса","Коментарі до замовлення"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    private func setUpViews() {
        view.addSubview(infoTableView)
        infoTableView.layout {
            $0.constraint(to: view, by: .trailing(0),.bottom(0),.leading(0),.top(0))
        }
    }
}

extension OrderViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return foodArr.count
        case 1:
            return destinationCellsInfo.count
        case 2:
            return destinationCellsInfo.count
        case 3:
            return 5
        case 5:
            return 1
        default:
            return cellsArr[section].name?.count ?? 00
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = BasketPizzaCells.deque(for: tableView, indexPath: indexPath) else {
                return UITableViewCell()
            }
            cell.setUp(arr: OrderService.shared.productArr()[indexPath.row])
            return cell
        case 1:
//            tableView.cellForRow(at: indexPath)?.imageView?.frame = CGRect(x: 0,y: 0,width: 32,height: 32)
            guard let cell = DestinationCells.deque(for: tableView, indexPath: indexPath) else {
                return UITableViewCell()
            }
            cell.contentView.isUserInteractionEnabled = true
            cell.setUp(infoStr: destinationCellsInfo[indexPath.row], descriptStr: destinationCellsDescription[indexPath.row], image: UIImage(named: destinationCellsIcons[0]) ?? UIImage())
            return cell
        case 2:
            tableView.cellForRow(at: indexPath)?.imageView?.sizeToFit()
            guard let cell = DestinationCells.deque(for: tableView, indexPath: indexPath) else {
                return UITableViewCell()
            }
            cell.contentView.isUserInteractionEnabled = true
            cell.setUp(infoStr: payMethod[indexPath.row], descriptStr: payMethodDesription[indexPath.row], image: UIImage(named: destinationCellsIcons[0]) ?? UIImage())
            return cell

        case 3:
            guard let cell = InfoFieldCells.deque(for: tableView, indexPath: indexPath) else {
                return UITableViewCell()
            }
            cell.contentView.isUserInteractionEnabled = false
            cell.setUp(textlabel: contactsInfoLabels[indexPath.row])
            return cell

        case 4:
            guard let cell = ConfirmOrderCell.deque(for: tableView, indexPath: indexPath) else {
                return UITableViewCell()
            }
            cell.setUpViews()
            return cell
        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 80/812*Size.heigth
        case 1:
            return 100/812*Size.heigth
        case 2:
            return UITableView.automaticDimension
        case 3:
            return 75.0
        case 4:
            return 60.0
        default:
            return 100.0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0/812*Size.heigth
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        
        switch section {
        case 0:
            let headerView = HeaderTableView()
            headerView.setUp(text: titles[section])
            headerView.backgroundColor = UIColor.init(hexString:"#861901")
            return headerView
        case 1:
            let headerView = HeaderTableView()
            headerView.backgroundColor = .black
            headerView.setUp(text: titles[section])
            return headerView
        case 2:
            let headerView = HeaderTableView()
            headerView.backgroundColor = .black
            headerView.setUp(text: titles[section])
            return headerView
        case 3:
            let headerView = HeaderTableView()
            headerView.backgroundColor = .black
            headerView.setUp(text: titles[section])
            return headerView
        case 4:
            let headerView = HeaderTableView()
            headerView.backgroundColor = .black
            headerView.setUp(text: titles[section])
            return headerView
        default:
            return UIView()
        }
    }
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
                switch indexPath.section {
                case 0:
                    break
                case 1:
                    let cell = DestinationCells.deque(for: tableView, indexPath: indexPath)
//                    cell?.iconImage.image = UIImage(named: destinationCellsIcons[0]) ?? UIImage()
//                    cell?.setUp(infoStr: destinationCellsInfo[indexPath.row], descriptStr: destinationCellsDescription[indexPath.row], image: UIImage(named: destinationCellsIcons[1]) ?? UIImage())
                    cell?.changeIcon()
                    cell?.isSelected = true
                case 2:
                    let cell = DestinationCells.deque(for: tableView, indexPath: indexPath)
                    
                case 3:
                    break
                case 4:
                    break
                default:
                    break
                }
        }
    
        func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
            switch indexPath.section {
            case 0:
                break
            case 1:
                let cell = DestinationCells.deque(for: tableView, indexPath: indexPath)
//                cell?.iconImage.image = UIImage(named: destinationCellsIcons[0]) ?? UIImage()
                cell?.setUp(infoStr: destinationCellsInfo[indexPath.row], descriptStr: destinationCellsDescription[indexPath.row], image: UIImage(named: destinationCellsIcons[0]) ?? UIImage())
                cell?.isSelected = false
            case 2:
                let cell = DestinationCells.deque(for: tableView, indexPath: indexPath)
//                cell?.changeIcon(image: UIImage(named: destinationCellsIcons[1]) ?? UIImage())
            case 3:
                break
            case 4:
                break
            default:
                break
            }
        }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}

//
//  ShoppingCartViewController.swift
//  AnabelsGrocery
//
//  Created by 张彦哲 on 2023/5/3.
//

import UIKit

class ShoppingCartViewController: UIViewController {
    
    var totalPrice : Float = 0.0
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ShoppingCartTableViewCell.self, forCellReuseIdentifier: "CartItemTableViewCell")
        return tableView
    }()
    let priceLabel = UILabel()
    let reserveBtn = UIButton()
    let stackView = UIStackView()
    
    var orderContent = [[String:Int]]()
    var itemsInOrder = [Product]()
    weak var delegate: ShoppingCartViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Cart"
        view.backgroundColor = .white
        
        UserDefaults.standard.set(totalPrice, forKey: "totalPrice")
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        priceLabel.font = .boldSystemFont(ofSize: 18)
        priceLabel.textColor = .black
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        reserveBtn.setTitle("Reserve", for: .normal)
        reserveBtn.layer.cornerRadius = 10.0
        reserveBtn.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        reserveBtn.setTitleColor(.white, for: .normal)
        reserveBtn.setContentHuggingPriority(.required, for: .horizontal)
        reserveBtn.addTarget(self, action: #selector(onReserve), for: .touchUpInside)
        reserveBtn.translatesAutoresizingMaskIntoConstraints = false
        
        let spacerView = UIView()
        spacerView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        spacerView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(spacerView)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(reserveBtn)
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        setupConstraints()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        calculateTotalPrice()
        tableView.reloadData()
    }

    
    func setupConstraints() {
        let padding = 16.0
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: stackView.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            stackView.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: padding),
            stackView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc func onReserve() {
        // update total price in user defaults
        UserDefaults.standard.set(totalPrice, forKey: "totalPrice")
        


        var products = Utilities.getProductsFromUserDefaults()

        // create order
        for i in 0..<products.count {
            for j in 0..<products[i].count {
                if products[i][j].selectedNum > 0 {
                    itemsInOrder.append(products[i][j])
                    orderContent.append([
                        "inventory_id": products[i][j].id,
                        "num_sel" :products[i][j].selectedNum
                    ])
                }
                products[i][j].selectedNum = 0
            }
        }
        NetworkManager.shared.createOrder(total_price: totalPrice, inventories: orderContent) { order in
            print("success")
        }
        
        Utilities.updateProductsFromUserDefaults(newProducts: products)
        print(allSelectedNumZero())
        
        // reset totalPrice value and products in user defaults
        totalPrice = 0.0
        
        //delegate?.passDataToReservation(data: itemsInOrder)
        Utilities.updateReservationFromUserDefaults(newArray: itemsInOrder)
        
        // navigate to the reservation page
        self.navigationController?.pushViewController(ReservationViewController(itemsInOrder: itemsInOrder), animated: true)
    }
    
    // helper functions
    func allSelectedNumZero() -> Bool{
        let products = Utilities.getProductsFromUserDefaults()
        for i in 0..<products.count {
            for j in 0..<products[i].count {
                if products[i][j].selectedNum > 0 {
                    return false
                }
            }
        }
        return true
    }
    
    func calculateTotalPrice() {
        let products = Utilities.getProductsFromUserDefaults()
        let order = Utilities.getReservationFromUserDefaults()
        totalPrice = 0.0
        for i in 0..<products.count {
            for j in 0..<products[i].count {
                totalPrice += Float(products[i][j].selectedNum) * products[i][j].price
            }
        }
        if (totalPrice == 0.0 || order.count != 0) {
            reserveBtn.isEnabled = false
            reserveBtn.backgroundColor = .systemGray
        } else {
            reserveBtn.isEnabled = true
            reserveBtn.backgroundColor = Utilities.hexStringToUIColor(hex: "#38AB4A")
        }
        if allSelectedNumZero() {
            totalPrice = 0
            //UserDefaults.standard.set(totalPrice, forKey: "totalPrice")
        }
        priceLabel.text = "Total: " + String(format: "$%.2f", totalPrice)
    }
}

extension ShoppingCartViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        let products = Utilities.getProductsFromUserDefaults()
        if allSelectedNumZero() {
            return 0
        }
        return products.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let products = Utilities.getProductsFromUserDefaults()
        return products[section].filter { $0.selectedNum > 0 }.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartItemTableViewCell", for: indexPath) as! ShoppingCartTableViewCell
        let products = Utilities.getProductsFromUserDefaults()
        let filteredItems = products[indexPath.section].filter { $0.selectedNum > 0 }
        let item = filteredItems[indexPath.row]
        cell.configure(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let products = Utilities.getProductsFromUserDefaults()
        let filteredItems = products[indexPath.section].filter { $0.selectedNum > 0 }
        let item = filteredItems[indexPath.row]
        self.navigationController?.pushViewController(DetailsViewController(product: item), animated: true)
    }
}

protocol ShoppingCartViewControllerDelegate: AnyObject {
    func passDataToReservation(data: [Product])
}

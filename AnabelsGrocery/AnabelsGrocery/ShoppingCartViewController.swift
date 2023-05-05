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
        
        // reset totalPrice value and products in user defaults
        totalPrice = 0.0
        var products = getProductsFromUserDefaults()
        for i in 0..<products.count {
            for j in 0..<products[i].count {
                products[i][j].selectedNum = 0
            }
        }
        updateProductsFromUserDefaults(newProducts: products)
        
        // navigate to the reservation page
        self.navigationController?.pushViewController(ReservationViewController(), animated: true)
    }
    
    // helper functions
    func calculateTotalPrice() {
        let products = getProductsFromUserDefaults()
        totalPrice = 0.0
        for i in 0..<products.count {
            for j in 0..<products[i].count {
                totalPrice += Float(products[i][j].selectedNum) * products[i][j].price
            }
        }
        if (totalPrice == 0.0) {
            reserveBtn.isEnabled = false
            reserveBtn.backgroundColor = .systemGray
        } else {
            reserveBtn.isEnabled = true
            reserveBtn.backgroundColor = hexStringToUIColor(hex: "#38AB4A")
        }
        priceLabel.text = "Total: " + String(format: "$%.2f", totalPrice)
    }
    
    func getProductsFromUserDefaults() -> [[Product]] {
        var products: [[Product]] = [[]]
        if let data = UserDefaults.standard.data(forKey: "products") {
            do {
                let decoder = JSONDecoder()
                products = try decoder.decode([[Product]].self, from: data)
            } catch {
                print("Unable to Decode Notes (\(error))")
            }
        }
        return products
    }
    
    func updateProductsFromUserDefaults(newProducts: [[Product]]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(newProducts)
            UserDefaults.standard.set(data, forKey: "products")
        } catch {
            print("Unable to Encode Note (\(error))")
        }
    }

    func hexStringToUIColor(hex: String, alpha: CGFloat = 1.0) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    
}

extension ShoppingCartViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        let products = getProductsFromUserDefaults()
        return products.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let products = getProductsFromUserDefaults()
        return products[section].filter { $0.selectedNum > 0 }.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartItemTableViewCell", for: indexPath) as! ShoppingCartTableViewCell
        let products = getProductsFromUserDefaults()
        let filteredItems = products[indexPath.section].filter { $0.selectedNum > 0 }
        let item = filteredItems[indexPath.row]
        cell.configure(with: item)
        return cell
    }
}

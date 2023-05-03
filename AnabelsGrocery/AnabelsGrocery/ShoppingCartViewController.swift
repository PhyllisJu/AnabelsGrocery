//
//  ShoppingCartViewController.swift
//  AnabelsGrocery
//
//  Created by 张彦哲 on 2023/5/3.
//

import UIKit

class ShoppingCartViewController: UIViewController {
    
    var items = [Product]()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ShoppingCartTableViewCell.self, forCellReuseIdentifier: "CartItemTableViewCell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        

        title = "Shopping Cart"
        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        tableView.reloadData()
        
        setupConstraints()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func reload() {
        tableView.reloadData()
    }
    
    func getUserDefaults() -> [[Product]] {
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
    

    
}

extension ShoppingCartViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        let products = getUserDefaults()
        return products.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let products = getUserDefaults()
        return products[section].filter { $0.selectedNum > 0 }.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartItemTableViewCell", for: indexPath) as! ShoppingCartTableViewCell
        let products = getUserDefaults()
        let filteredItems = products[indexPath.section].filter { $0.selectedNum > 0 }
        let item = filteredItems[indexPath.row]
        cell.configure(with: item)
        return cell
    }
}

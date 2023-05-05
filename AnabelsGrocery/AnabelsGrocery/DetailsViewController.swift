//
//  DetailsViewController.swift
//  AnabelsGrocery
//
//  Created by Phyllis Ju on 4/28/23.
//

import UIKit

class DetailsViewController: UIViewController {
    let picImageView = UIImageView()
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()
    let priceLabel = UILabel()
    let addButton = UIButton()
    let subtractButton = UIButton()
    let quantityLabel = UILabel()
    let addToCartButton = UIButton()
//    let inventoryLabel = UILabel()
    let messageLabel = UILabel()
    var product: Product
    var products: [[Product]]
    var productRow: Int
    var productCol: Int
    
    init(products: [[Product]], row: Int, col: Int) {
        self.products = products
        self.product = products[row][col]
        self.productRow = row
        self.productCol = col
        super.init(nibName: nil, bundle: nil)
        
    }
    
    init(product: Product) {
        var products: [[Product]] = [[]]
        if let data = UserDefaults.standard.data(forKey: "products") {
            do {
                let decoder = JSONDecoder()
                products = try decoder.decode([[Product]].self, from: data)
            } catch {
                print("Unable to Decode Notes (\(error))")
            }
        }
        self.product = product
        self.products = products
        
        let rowIndex = products.firstIndex(where: { $0.contains { $0.name == product.name } })
        let colIndex = products[rowIndex!].firstIndex(where: { $0.name == product.name })
        

        self.productRow = rowIndex!
        self.productCol = colIndex!
        super.init(nibName: nil, bundle: nil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = product.name
        view.backgroundColor = .white
        
        picImageView.image = UIImage(named: product.image)
        picImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(picImageView)
        
        nameLabel.text = product.name
        nameLabel.font = .boldSystemFont(ofSize: 30)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        descriptionLabel.text = product.description
        descriptionLabel.font = .systemFont(ofSize: 16)
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionLabel)
        
        priceLabel.text = "$\(product.price)"
        priceLabel.font = .systemFont(ofSize: 30)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(priceLabel)
        
        addButton.setTitle("+", for: .normal)
        addButton.titleLabel?.font = .systemFont(ofSize: 30)
        addButton.setTitleColor(.white, for: .normal)
        addButton.backgroundColor = hexStringToUIColor(hex: "#38AB4A")
        addButton.layer.cornerRadius = 5.0
        addButton.addTarget(self, action: #selector(addQuantity), for: .touchUpInside)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addButton)
        
        subtractButton.setTitle("-", for: .normal)
        subtractButton.titleLabel?.font = .systemFont(ofSize: 35)
        subtractButton.setTitleColor(.white, for: .normal)
        subtractButton.backgroundColor = hexStringToUIColor(hex: "#38AB4A")
        subtractButton.layer.cornerRadius = 5.0
        subtractButton.addTarget(self, action: #selector(subtractQuantity), for: .touchUpInside)
        subtractButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subtractButton)
        
        quantityLabel.text = String(product.selectedNum)
        quantityLabel.textAlignment = .center
        quantityLabel.font = .systemFont(ofSize: 20)
        quantityLabel.backgroundColor = .clear
        quantityLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(quantityLabel)
        
        addToCartButton.setTitle("Confirm", for: .normal)
        addToCartButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        addToCartButton.backgroundColor = hexStringToUIColor(hex: "#38AB4A")
        addToCartButton.layer.cornerRadius = 10.0
        addToCartButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        addToCartButton.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addToCartButton)
        
        messageLabel.text = ""
        messageLabel.font = UIFont.boldSystemFont(ofSize: 15)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.lineBreakMode = .byWordWrapping
        messageLabel.numberOfLines = 0
        view.addSubview(messageLabel)
    
        setupConstraints()
    }
    
    @objc func addQuantity() {
        if (product.selectedNum < 30) {
            product.selectedNum += 1
            quantityLabel.text = "\(String(product.selectedNum))"
            messageLabel.text = ""
        } else {
            messageLabel.text = "Quantity is too large."
            messageLabel.textColor = .red
        }

    }
    
    @objc func subtractQuantity() {
        if (product.selectedNum > 0) {
            product.selectedNum -= 1
            messageLabel.text = ""
        }
        quantityLabel.text = "\(String(product.selectedNum))"
    }
    
    @objc func addToCart() {
        products[productRow][productCol] = product
        updateProductsFromUserDefaults(newProducts: products)
        messageLabel.text = "Successfully added to the shopping cart!"
        messageLabel.textColor = .green
        if let indices = indicesOf(x: product, array: products) {
            print(indices[0])
            print(indices[1])
        }
    }
    
    func setupConstraints() {
        let padding = 16.0
        
        NSLayoutConstraint.activate([
            picImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            picImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            picImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            picImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: picImageView.bottomAnchor, constant: padding),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
        ])
        
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: picImageView.bottomAnchor, constant: padding),
            priceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: padding),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
        ])
        
        NSLayoutConstraint.activate([
            subtractButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: padding),
            subtractButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            subtractButton.widthAnchor.constraint(equalToConstant: 35),
            subtractButton.heightAnchor.constraint(equalToConstant: 35),

        ])
        
        NSLayoutConstraint.activate([
            quantityLabel.centerYAnchor.constraint(equalTo: subtractButton.centerYAnchor),
            quantityLabel.leadingAnchor.constraint(equalTo: subtractButton.trailingAnchor, constant: 3),
            quantityLabel.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -3),
            quantityLabel.topAnchor.constraint(equalTo: subtractButton.topAnchor, constant: 1),
            quantityLabel.bottomAnchor.constraint(equalTo: subtractButton.bottomAnchor, constant: -1),
        ])
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            addButton.leadingAnchor.constraint(equalTo: quantityLabel.leadingAnchor, constant: 40),
            addButton.widthAnchor.constraint(equalToConstant: 35),
            addButton.heightAnchor.constraint(equalToConstant: 35),
        ])
        
        NSLayoutConstraint.activate([
            addToCartButton.centerYAnchor.constraint(equalTo: addButton.centerYAnchor),
            addToCartButton.leadingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: 80),
            addToCartButton.widthAnchor.constraint(equalToConstant: 140),
            addToCartButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: subtractButton.bottomAnchor, constant: 20),
            messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            messageLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
        ])
        
    }
    
    // helper functions
    func updateProductsFromUserDefaults(newProducts: [[Product]]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(newProducts)
            UserDefaults.standard.set(data, forKey: "products")
        } catch {
            print("Unable to Encode Note (\(error))")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func indicesOf(x: Product, array: [[Product]]) -> [Int]? {
        if let rowIndex = array.firstIndex(where: { $0.contains { $0.name == x.name } }),
           let colIndex = array[rowIndex].firstIndex(where: { $0.name == x.name }) {
            return [rowIndex, colIndex]
        } else {
            return nil
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


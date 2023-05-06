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
    let descriptionTextView = UITextView()
    let priceLabel = UILabel()
    let addButton = UIButton()
    let subtractButton = UIButton()
    let quantityLabel = UILabel()
    let addToCartButton = UIButton()
    let messageLabel = UILabel()
    var product: Product
    var products: [[Product]]
    var productRow: Int
    var productCol: Int
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
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
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = contentView.bounds.size
        view.addSubview(scrollView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.frame = CGRect(x: 0, y: 0, width: scrollView.contentSize.width, height: scrollView.contentSize.height)
        scrollView.addSubview(contentView)
        
        picImageView.image = UIImage(named: product.image)
        picImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(picImageView)
        
        nameLabel.text = product.name
        nameLabel.font = .boldSystemFont(ofSize: 30)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        
        descriptionTextView.text = product.description
        descriptionTextView.font = .systemFont(ofSize: 16)
        descriptionTextView.isEditable = false
        descriptionTextView.isScrollEnabled = false
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(descriptionTextView)
        
        priceLabel.text = "$\(product.price)"
        priceLabel.font = .boldSystemFont(ofSize: 30)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(priceLabel)
        
        addButton.setTitle("+", for: .normal)
        addButton.titleLabel?.font = .systemFont(ofSize: 30)
        addButton.setTitleColor(.white, for: .normal)
        addButton.backgroundColor = Utilities.hexStringToUIColor(hex: "#38AB4A")
        addButton.layer.cornerRadius = 5.0
        addButton.addTarget(self, action: #selector(addQuantity), for: .touchUpInside)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(addButton)
        
        subtractButton.setTitle("-", for: .normal)
        subtractButton.titleLabel?.font = .systemFont(ofSize: 35)
        subtractButton.setTitleColor(.white, for: .normal)
        subtractButton.backgroundColor = Utilities.hexStringToUIColor(hex: "#38AB4A")
        subtractButton.layer.cornerRadius = 5.0
        subtractButton.addTarget(self, action: #selector(subtractQuantity), for: .touchUpInside)
        subtractButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(subtractButton)
        
        quantityLabel.textAlignment = .center
        quantityLabel.font = .systemFont(ofSize: 20)
        quantityLabel.backgroundColor = .clear
        quantityLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(quantityLabel)
        
        addToCartButton.setTitle("Confirm", for: .normal)
        addToCartButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        addToCartButton.backgroundColor = Utilities.hexStringToUIColor(hex: "#38AB4A")
        addToCartButton.layer.cornerRadius = 10.0
        addToCartButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        addToCartButton.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(addToCartButton)
        
        messageLabel.text = ""
        messageLabel.font = UIFont.boldSystemFont(ofSize: 15)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.lineBreakMode = .byWordWrapping
        messageLabel.numberOfLines = 0
        contentView.addSubview(messageLabel)
    
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        quantityLabel.text = String(product.selectedNum)
    }
    
    @objc func addQuantity() {
        if (product.selectedNum < 30) {
            product.selectedNum += 1
            quantityLabel.text = "\(String(product.selectedNum))"
            messageLabel.text = ""
            addToCartButton.isEnabled = true
            addToCartButton.backgroundColor = Utilities.hexStringToUIColor(hex: "#38AB4A")
        } else {
            messageLabel.text = "Quantity is too large."
            messageLabel.textColor = .red
            addToCartButton.isEnabled = false
            addToCartButton.backgroundColor = .systemGray
        }

    }
    
    @objc func subtractQuantity() {
        if (product.selectedNum > 0) {
            product.selectedNum -= 1
            messageLabel.text = ""
            addToCartButton.isEnabled = true
            addToCartButton.backgroundColor = Utilities.hexStringToUIColor(hex: "#38AB4A")
        }
        quantityLabel.text = "\(String(product.selectedNum))"
    }
    
    @objc func addToCart() {
        products[productRow][productCol] = product
        Utilities.updateProductsFromUserDefaults(newProducts: products)
        messageLabel.text = "Successfully added to the shopping cart!"
        messageLabel.textColor = Utilities.hexStringToUIColor(hex: "#2C3684")
//        if let indices = indicesOf(x: product, array: products) {
//            print(indices[0])
//            print(indices[1])
//        }
    }
    
    func setupConstraints() {
        let padding = 16.0
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            picImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            picImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            picImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9),
            picImageView.heightAnchor.constraint(equalTo: picImageView.widthAnchor, multiplier: picImageView.image!.size.height / picImageView.image!.size.width)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: picImageView.bottomAnchor, constant: padding),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
        ])
        
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: picImageView.bottomAnchor, constant: padding),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
        ])
        
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: padding),
            descriptionTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            descriptionTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            descriptionTextView.bottomAnchor.constraint(equalTo: addToCartButton.topAnchor, constant: -padding)
        ])
        
        NSLayoutConstraint.activate([
            subtractButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            subtractButton.widthAnchor.constraint(equalToConstant: 35),
            subtractButton.heightAnchor.constraint(equalToConstant: 35),
            subtractButton.bottomAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -padding)
        ])
        
        NSLayoutConstraint.activate([
            quantityLabel.centerYAnchor.constraint(equalTo: subtractButton.centerYAnchor),
            quantityLabel.leadingAnchor.constraint(equalTo: subtractButton.trailingAnchor, constant: 3),
            quantityLabel.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -3),
            quantityLabel.topAnchor.constraint(equalTo: subtractButton.topAnchor, constant: 1),
            quantityLabel.bottomAnchor.constraint(equalTo: subtractButton.bottomAnchor, constant: -1),
        ])
        
        NSLayoutConstraint.activate([
            addButton.centerYAnchor.constraint(equalTo: subtractButton.centerYAnchor),
            addButton.leadingAnchor.constraint(equalTo: quantityLabel.leadingAnchor, constant: 40),
            addButton.widthAnchor.constraint(equalToConstant: 35),
            addButton.heightAnchor.constraint(equalToConstant: 35),
            addButton.bottomAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -padding)
        ])
        
        NSLayoutConstraint.activate([
            addToCartButton.centerYAnchor.constraint(equalTo: subtractButton.centerYAnchor),
            addToCartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            addToCartButton.widthAnchor.constraint(equalToConstant: 140),
            addToCartButton.heightAnchor.constraint(equalToConstant: 50),
            addToCartButton.bottomAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -padding)
        ])
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: subtractButton.bottomAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        ])
        
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
}


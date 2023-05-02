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
    let inventoryLabel = UILabel()
    let messageLabel = UILabel()
    let product: Product
    
    var quantity: Int
    
    init(product: Product) {
        self.product = product
        self.quantity = 0
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
        nameLabel.font = .systemFont(ofSize: 20)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        descriptionLabel.text = product.description
        descriptionLabel.font = .systemFont(ofSize: 16)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionLabel)
        
        priceLabel.text = "$\(product.price)"
        priceLabel.font = .systemFont(ofSize: 30)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(priceLabel)
        
        inventoryLabel.text = "Currenty in stock: \(product.inventory)"
        inventoryLabel.font = .systemFont(ofSize: 16)
        inventoryLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(inventoryLabel)
        
        addButton.setTitle("+", for: .normal)
        addButton.titleLabel?.font = .systemFont(ofSize: 35)
        addButton.setTitleColor(.white, for: .normal)
        addButton.backgroundColor = .systemPurple
        addButton.addTarget(self, action: #selector(addQuantity), for: .touchUpInside)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addButton)
        
        subtractButton.setTitle("-", for: .normal)
        subtractButton.titleLabel?.font = .systemFont(ofSize: 35)
        subtractButton.setTitleColor(.white, for: .normal)
        subtractButton.backgroundColor = .systemPurple
        subtractButton.addTarget(self, action: #selector(subtractQuantity), for: .touchUpInside)
        subtractButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subtractButton)
        
        quantityLabel.text = String(quantity)
        quantityLabel.textAlignment = .center
        quantityLabel.font = .systemFont(ofSize: 20)
        quantityLabel.backgroundColor = .systemGray5
        quantityLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(quantityLabel)
        
        addToCartButton.setTitle("Add to cart", for: .normal)
        addToCartButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        addToCartButton.setTitleColor(.systemPurple, for: .normal)
        addToCartButton.layer.cornerRadius = 5
        addToCartButton.layer.borderWidth = 2
        addToCartButton.layer.borderColor = UIColor.purple.cgColor
        addToCartButton.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addToCartButton)
        
        messageLabel.text = ""
        messageLabel.font = UIFont.boldSystemFont(ofSize: 20)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.lineBreakMode = .byWordWrapping
        messageLabel.numberOfLines = 0
        view.addSubview(messageLabel)
        
        
        
        
        setupConstraints()
        // TODO: implement the details page and navigation
    }
    
    @objc func addQuantity() {
        if (quantity < product.inventory) {
            quantity = quantity + 1
            quantityLabel.text = "\(String(quantity))"
            messageLabel.text = ""
        } else {
            messageLabel.text = "Quantity cannot be more than \(product.inventory)"
            messageLabel.textColor = .red
        }

    }
    
    @objc func subtractQuantity() {
        if (quantity > 0) {
            quantity = quantity - 1
            messageLabel.text = ""
        }
        quantityLabel.text = "\(String(quantity))"
    }
    
    @objc func addToCart() {
        if (quantity == 0) {
            messageLabel.text = "Quantity should be at least 1."
            messageLabel.textColor = .red
            return
        }
    
        product.inventory -= quantity
        messageLabel.text = "Successfully added \(quantity) \(product.name) to the shopping cart!"
        messageLabel.textColor = .green
        
        quantity = 0
        quantityLabel.text = "\(quantity)"
        
        inventoryLabel.text = "Currenty in stock: \(product.inventory)"
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            picImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            picImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            picImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            picImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: picImageView.bottomAnchor, constant: 40),
            nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
        
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            priceLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
        ])
        
        NSLayoutConstraint.activate([
            inventoryLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 5),
            inventoryLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
        ])
        
        NSLayoutConstraint.activate([
            subtractButton.topAnchor.constraint(equalTo: inventoryLabel.bottomAnchor, constant: 20),
            subtractButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            subtractButton.widthAnchor.constraint(equalToConstant: 40),
            subtractButton.heightAnchor.constraint(equalToConstant: 40),

        ])
        
        NSLayoutConstraint.activate([
            quantityLabel.centerYAnchor.constraint(equalTo: subtractButton.centerYAnchor),
            quantityLabel.leftAnchor.constraint(equalTo: subtractButton.rightAnchor, constant: 3),
            quantityLabel.rightAnchor.constraint(equalTo: addButton.leftAnchor, constant: -3),
            quantityLabel.topAnchor.constraint(equalTo: subtractButton.topAnchor, constant: 1),
            quantityLabel.bottomAnchor.constraint(equalTo: subtractButton.bottomAnchor, constant: -1),
        ])
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: inventoryLabel.bottomAnchor, constant: 20),
            addButton.leftAnchor.constraint(equalTo: quantityLabel.leftAnchor, constant: 40),
            addButton.widthAnchor.constraint(equalToConstant: 40),
            addButton.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        NSLayoutConstraint.activate([
            addToCartButton.centerYAnchor.constraint(equalTo: addButton.centerYAnchor),
            addToCartButton.leftAnchor.constraint(equalTo: addButton.leftAnchor, constant: 80),
            addToCartButton.widthAnchor.constraint(equalToConstant: 140),
            addToCartButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: subtractButton.bottomAnchor, constant: 20),
            messageLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            messageLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 40),
            messageLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


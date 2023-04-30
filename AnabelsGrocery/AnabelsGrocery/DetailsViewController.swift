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
    let priceLabel = UILabel()
    let addButton = UIButton()
    let subtractButton = UIButton()
    let quantityLabel = UILabel()
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
        
        priceLabel.text = "$\(product.price)"
        priceLabel.font = .systemFont(ofSize: 30)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(priceLabel)
        
        addButton.setTitle("+", for: .normal)
        addButton.setTitleColor(.white, for: .normal)
        addButton.backgroundColor = .systemPurple
        addButton.addTarget(self, action: #selector(addQuantity), for: .touchUpInside)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addButton)
        
        subtractButton.setTitle("-", for: .normal)
        subtractButton.setTitleColor(.white, for: .normal)
        subtractButton.backgroundColor = .systemPurple
        subtractButton.addTarget(self, action: #selector(subtractQuantity), for: .touchUpInside)
        subtractButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subtractButton)
        
        quantityLabel.text = String(quantity)
        quantityLabel.textAlignment = .center
        quantityLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(quantityLabel)
        
        setupConstraints()
        // TODO: implement the details page and navigation
    }
    
    @objc func addQuantity() {
        quantity = quantity + 1
        quantityLabel.text = "\(String(quantity))"
    }
    
    @objc func subtractQuantity() {
        if (quantity > 0) {
            quantity = quantity - 1
        }
        quantityLabel.text = "\(String(quantity))"
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
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            priceLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
        ])
        
        NSLayoutConstraint.activate([
            subtractButton.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 20),
            subtractButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
        ])
        
        NSLayoutConstraint.activate([
            quantityLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 20),
            quantityLabel.leftAnchor.constraint(equalTo: subtractButton.leftAnchor, constant: 40),
        ])
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 20),
            addButton.leftAnchor.constraint(equalTo: quantityLabel.leftAnchor, constant: 40),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


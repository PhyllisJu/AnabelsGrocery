//
//  ProductCollectionViewCell.swift
//  AnabelsGrocery
//
//  Created by Phyllis Ju on 4/28/23.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    let productImageView = UIImageView()
    let nameLabel = UILabel()
    let priceLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = CGColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        contentView.layer.cornerRadius = 10
        
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(productImageView)
        
        nameLabel.font = .systemFont(ofSize: 18)
        nameLabel.textColor = .black
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        
        priceLabel.font = .systemFont(ofSize: 15)
        priceLabel.textColor = .systemGray
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(priceLabel)
        
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            productImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            productImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            productImageView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.6),
            productImageView.heightAnchor.constraint(equalTo: productImageView.widthAnchor, multiplier: 1)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            priceLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10)
        ])
    }
    
    func update(product: Product) {
        productImageView.image = UIImage(named: product.image)
        nameLabel.text = product.name
        priceLabel.text = "\(product.price)"
    }
}

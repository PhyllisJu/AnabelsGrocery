//
//  ReservationCollectionViewCell.swift
//  AnabelsGrocery
//
//  Created by 张彦哲 on 2023/5/5.
//

import UIKit

class ReservationCollectionViewCell: UICollectionViewCell {
    let productImageView = UIImageView()
    let nameLabel = UILabel()
    let quantityLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = CGColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        contentView.layer.cornerRadius = 10
        
        productImageView.layer.cornerRadius = 10
        productImageView.clipsToBounds = true
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(productImageView)
        
        nameLabel.font = .systemFont(ofSize: 18)
        nameLabel.textColor = .black
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        
        quantityLabel.font = .systemFont(ofSize: 15)
        quantityLabel.textColor = .systemGray
        quantityLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(quantityLabel)
        
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            productImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            productImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            productImageView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 1),
            productImageView.heightAnchor.constraint(equalTo: productImageView.widthAnchor, multiplier: 0.7)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            quantityLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            quantityLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10)
        ])
    }
    
    func update(product: Product) {
        productImageView.image = UIImage(named: product.image)
        nameLabel.text = product.name
        quantityLabel.text = "Quantity: \(product.selectedNum)"
    }
}

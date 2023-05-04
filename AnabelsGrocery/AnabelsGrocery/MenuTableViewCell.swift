//
//  MenuTableViewCell.swift
//  AnabelsGrocery
//
//  Created by 张彦哲 on 2023/5/3.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    let itemImageView = UIImageView()
    let nameLabel = UILabel()
    let priceLabel = UILabel()
    let quantityLabel = UILabel()
    let totalPriceLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(itemImageView)
        
        nameLabel.font = .systemFont(ofSize: 20)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(nameLabel)
        
        priceLabel.font = .systemFont(ofSize: 15)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(priceLabel)
        
        quantityLabel.font = .systemFont(ofSize: 15)
        quantityLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(quantityLabel)
        
        totalPriceLabel.font = .systemFont(ofSize: 20)
        totalPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(totalPriceLabel)
        
        setUpConstraints()
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            itemImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            itemImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            itemImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            itemImageView.widthAnchor.constraint(equalToConstant: 80),
            itemImageView.heightAnchor.constraint(equalToConstant: 80),
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
        ])
        
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 8),
            priceLabel.widthAnchor.constraint(equalToConstant: 80),
        ])
        
        NSLayoutConstraint.activate([
            quantityLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            quantityLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 8),
            quantityLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
        
        NSLayoutConstraint.activate([
            totalPriceLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            totalPriceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            totalPriceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            totalPriceLabel.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with item: Product) {
        itemImageView.image = UIImage(named: item.image)
        nameLabel.text = item.name
        priceLabel.text = String(format: "$%.2f", item.price)
        quantityLabel.text = "Quantity: \(item.selectedNum)"
        totalPriceLabel.text = String(format: "$%.2f", Float(item.selectedNum) * item.price)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}

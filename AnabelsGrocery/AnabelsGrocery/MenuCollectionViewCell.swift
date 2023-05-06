//
//  MenuCollectionViewCell.swift
//  AnabelsGrocery
//
//  Created by Phyllis Ju on 5/3/23.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    let menuImageView = UIImageView()
    let nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = CGColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        contentView.layer.cornerRadius = 10
        
        menuImageView.layer.cornerRadius = 10
        menuImageView.clipsToBounds = true
        menuImageView.contentMode = .scaleAspectFill
        menuImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(menuImageView)
        
        nameLabel.font = .systemFont(ofSize: 15)
        nameLabel.textColor = .black
        nameLabel.lineBreakMode = .byWordWrapping
        nameLabel.numberOfLines = 2
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            menuImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            menuImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            menuImageView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 1),
            menuImageView.heightAnchor.constraint(equalTo: menuImageView.widthAnchor, multiplier: 0.7)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: menuImageView.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10)
        ])
    }
    
    func update(menu: Menu) {
        menuImageView.image = UIImage(named: menu.image.url)
        nameLabel.text = menu.name
    }
}

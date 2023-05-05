//
//  FilterCollectionViewCell.swift
//  AnabelsGrocery
//
//  Created by Phyllis Ju on 4/28/23.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = .black
        contentView.addSubview(label)
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = .systemGray6
        
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(filterName: String, isSelected: Bool) {
        label.text = filterName
        if (isSelected) {
            contentView.backgroundColor = Utilities.hexStringToUIColor(hex: "#38AB4A")
            label.textColor = .white
        } else {
            contentView.backgroundColor = .systemGray6
            label.textColor = .black
        }
    }
}

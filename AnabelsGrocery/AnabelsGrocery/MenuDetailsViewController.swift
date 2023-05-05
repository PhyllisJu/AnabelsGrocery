//
//  MenuDetailsViewController.swift
//  AnabelsGrocery
//
//  Created by 张彦哲 on 2023/5/3.
//

import UIKit

class MenuDetailsViewController: UIViewController {
    
    let menu: Menu
    let picImageView = UIImageView()
    let nameLabel = UILabel()
    let descriptionTextView = UITextView()
    
    init(menu: Menu) {
        self.menu = menu
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = menu.name
        view.backgroundColor = .white
        
        picImageView.image = UIImage(named: menu.image)
        picImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(picImageView)
        
        nameLabel.text = menu.name
        nameLabel.font = .boldSystemFont(ofSize: 30)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        descriptionTextView.text = menu.description
        descriptionTextView.font = .systemFont(ofSize: 16)
        descriptionTextView.isEditable = false
        descriptionTextView.isScrollEnabled = true
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionTextView)
        
        setupConstraints()
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
            descriptionTextView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: padding),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            descriptionTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding) // TODO: figure out how to make this entire page scrollable
        ])
        
    }
}

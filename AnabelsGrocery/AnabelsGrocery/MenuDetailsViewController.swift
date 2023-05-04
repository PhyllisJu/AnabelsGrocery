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
    let descriptionLabel = UILabel()
    
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
        nameLabel.font = .systemFont(ofSize: 20)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        descriptionLabel.text = menu.description
        descriptionLabel.font = .systemFont(ofSize: 16)
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionLabel)
        
        setupConstraints()

        // Do any additional setup after loading the view.
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
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

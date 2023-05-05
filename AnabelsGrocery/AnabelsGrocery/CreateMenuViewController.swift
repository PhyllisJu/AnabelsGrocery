//
//  CreateMenuViewController.swift
//  AnabelsGrocery
//
//  Created by Phyllis Ju on 5/4/23.
//

import UIKit

class CreateMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Create Recipe"
        view.backgroundColor = .white
        
        let postBarButton = UIBarButtonItem(title: "Post", style: .plain, target: self, action: #selector(onPost))
        navigationItem.rightBarButtonItem = postBarButton
    }
    
    @objc func onPost() {
        
    }
}

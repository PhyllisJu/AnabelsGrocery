//
//  MenuViewController.swift
//  AnabelsGrocery
//
//  Created by Phyllis Ju on 5/2/23.
//

import UIKit

class MenuViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var products: [[Product]] = []
    private var menus: [Menu] = []
    
    // constants
    let itemPadding: CGFloat = 10
    let sectionPadding: CGFloat = 5
    let cellReuseID = "cellReuseID"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Recipes"
        view.backgroundColor = .white
        
        // sample data initialization
        products = Utilities.getProductsFromUserDefaults()
        menus = [
            Menu(image: "sample", name: "Recipe 1", description: "This is a placeholder menu description. This is a placeholder menu description. This is a placeholder menu description. This is a placeholder menu description. This is a placeholder menu description. This is a placeholder menu description.", ingredients: [products[0][1], products[1][1], products[2][0]]),
            Menu(image: "sample", name: "Recipe 2 Long Long Name", description: "This is a placeholder menu description. This is a placeholder menu description. This is a placeholder menu description. This is a placeholder menu description. This is a placeholder menu description. This is a placeholder menu description.", ingredients: [products[0][2], products[1][0]]),
            Menu(image: "sample", name: "Recipe 3", description: "This is a placeholder menu description. This is a placeholder menu description. This is a placeholder menu description. This is a placeholder menu description. This is a placeholder menu description. This is a placeholder menu description.", ingredients: [products[0][0], products[2][1], products[3][2], products[4][0], products[5][0], products[5][2]]),
            Menu(image: "sample", name: "Recipe 4", description: "This is a placeholder menu description. This is a placeholder menu description. This is a placeholder menu description. This is a placeholder menu description. This is a placeholder menu description. This is a placeholder menu description.", ingredients: [products[0][1], products[1][1], products[2][0]]),
            Menu(image: "sample", name: "Recipe 5", description: "This is a placeholder menu description. This is a placeholder menu description. This is a placeholder menu description. This is a placeholder menu description. This is a placeholder menu description. This is a placeholder menu description.", ingredients: [products[0][2], products[1][0]]),
            Menu(image: "sample", name: "Recipe 6", description: "This is a placeholder menu description. This is a placeholder menu description. This is a placeholder menu description. This is a placeholder menu description. This is a placeholder menu description. This is a placeholder menu description.", ingredients: [products[0][0], products[2][1], products[3][2], products[4][0], products[5][0], products[5][2]]),
            Menu(image: "sample", name: "Recipe 7", description: "This is a placeholder menu description. This is a placeholder menu description. This is a placeholder menu description. This is a placeholder menu description. This is a placeholder menu description. This is a placeholder menu description.", ingredients: [products[0][1], products[1][1], products[2][0]])
        ]
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = itemPadding
        flowLayout.minimumLineSpacing = itemPadding
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: sectionPadding, left: sectionPadding, bottom: sectionPadding, right: sectionPadding)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseID)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        setUpConstraints()
    }
    
    func setUpConstraints() {
        let collectionViewPadding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: collectionViewPadding),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: collectionViewPadding),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -collectionViewPadding),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -collectionViewPadding),
        ])
    }
}

extension MenuViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menus.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseID, for: indexPath) as? MenuCollectionViewCell {
            let menu = menus[indexPath.item]
            cell.update(menu: menu)
            return cell
        }
        return UICollectionViewCell()
    }
}

extension MenuViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let len = (view.frame.width - 2 * itemPadding - sectionPadding - 30) / 2
            return CGSize(width: len, height: len+10)
    }
}

extension MenuViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: redirect users to menu details page
        self.navigationController?.pushViewController(MenuDetailsViewController(menu: menus[indexPath.item]), animated: true)
//        self.navigationController?.pushViewController(DetailsViewController(menu: menus[indexPath.item]), animated: true)
    }
}


//
//  ViewController.swift
//  AnabelsGrocery
//
//  Created by Phyllis Ju on 4/28/23.
//

import UIKit

class ViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var filterCollectionView: UICollectionView!
    
    // sample data initialization
    private var filters: [Filter] = [Filter(name: "Produce", selected: false, id: 0), Filter(name: "Dairy", selected: false, id: 1), Filter(name: "Meat", selected: false, id: 2), Filter(name: "Snacks", selected: false, id: 3), Filter(name: "Beverages", selected: false, id: 4), Filter(name: "Condiments", selected: false, id: 5)]
    private var selectedFilters: [Int] = [] // selected filter ids
    
    private var initialSections = ["Produce", "Dairy", "Meat", "Snacks", "Beverages", "Condiments"]
    private var sections = ["Produce", "Dairy", "Meat", "Snacks", "Beverages", "Condiments"]
    
    private var initialProducts: [[Product]] = [
        [Product(image: "sample", name: "Apples", category: "Produce", price: 1.99, inventory: 30, description: "This is a placeholder description. This is a placeholder description. This is a placeholder description. This is a placeholder description. This is a placeholder description.", selectedNum: 0), Product(image: "sample", name: "Bananas", category: "Produce", price: 1.99, inventory: 30, description: "This is a placeholder description.", selectedNum: 0), Product(image: "sample", name: "Oranges", category: "Produce", price: 1.99, inventory: 30, description: "This is a placeholder description.", selectedNum: 0)],
        [Product(image: "sample", name: "Milk", category: "Dairy", price: 1.99, inventory: 30, description: "This is a placeholder description.", selectedNum: 0), Product(image: "sample", name: "Cheese", category: "Dairy", price: 1.99, inventory: 30, description: "This is a placeholder description.", selectedNum: 0), Product(image: "sample", name: "Yogurt", category: "Dairy", price: 1.99, inventory: 30, description: "This is a placeholder description.", selectedNum: 0), Product(image: "sample", name: "Eggs", category: "Dairy", price: 1.99, inventory: 30, description: "This is a placeholder description.", selectedNum: 0)],
        [Product(image: "sample", name: "Chicken", category: "Meat", price: 1.99, inventory: 30, description: "This is a placeholder description.", selectedNum: 0), Product(image: "sample", name: "Beef", category: "Meat", price: 1.99, inventory: 30, description: "This is a placeholder description.", selectedNum: 0)],
        [Product(image: "sample", name: "Chips", category: "Snacks", price: 1.99, inventory: 30, description: "This is a placeholder description.", selectedNum: 0), Product(image: "sample", name: "Pretzels", category: "Snacks", price: 1.99, inventory: 30, description: "This is a placeholder description.", selectedNum: 0), Product(image: "sample", name: "Nuts", category: "Snacks", price: 1.99, inventory: 30, description: "This is a placeholder description.", selectedNum: 0)],
        [Product(image: "sample", name: "Blood Orange Juice", category: "Beverages", price: 1.99, inventory: 30, description: "This is a placeholder description.", selectedNum: 0), Product(image: "sample", name: "Tangerine Juice", category: "Beverages", price: 1.99, inventory: 30, description: "This is a placeholder description.", selectedNum: 0), Product(image: "sample", name: "Water", category: "Beverages", price: 1.99, inventory: 30, description: "This is a placeholder description.", selectedNum: 0)],
        [Product(image: "sample", name: "Ketchup", category: "Condiments", price: 1.99, inventory: 30, description: "This is a placeholder description.", selectedNum: 0), Product(image: "sample", name: "Mustard", category: "Condiments", price: 1.99, inventory: 30, description: "This is a placeholder description.", selectedNum: 0), Product(image: "sample", name: "Hot Sauce", category: "Condiments", price: 1.99, inventory: 30, description: "This is a placeholder description.", selectedNum: 0)]
    ]
    
    private var products: [[Product]] = [
        [Product(image: "sample", name: "Apples", category: "Produce", price: 1.99, inventory: 30, description: "This is a placeholder description.", selectedNum: 0), Product(image: "sample", name: "Bananas", category: "Produce", price: 1.99, inventory: 30, description: "This is a placeholder description.", selectedNum: 0), Product(image: "sample", name: "Oranges", category: "Produce", price: 1.99, inventory: 30, description: "This is a placeholder description.", selectedNum: 0)],
        [Product(image: "sample", name: "Milk", category: "Dairy", price: 1.99, inventory: 30, description: "This is a placeholder description.", selectedNum: 0), Product(image: "sample", name: "Cheese", category: "Dairy", price: 1.99, inventory: 30, description: "This is a placeholder description.", selectedNum: 0), Product(image: "sample", name: "Yogurt", category: "Dairy", price: 1.99, inventory: 30, description: "This is a placeholder description.", selectedNum: 0), Product(image: "sample", name: "Eggs", category: "Dairy", price: 1.99, inventory: 30, description: "This is a placeholder description.", selectedNum: 0)],
        [Product(image: "sample", name: "Chicken", category: "Meat", price: 1.99, inventory: 30, description: "This is a placeholder description.", selectedNum: 0), Product(image: "sample", name: "Beef", category: "Meat", price: 1.99, inventory: 30, description: "This is a placeholder description.", selectedNum: 0)],
        [Product(image: "sample", name: "Chips", category: "Snacks", price: 1.99, inventory: 30, description: "This is a placeholder description.", selectedNum: 0), Product(image: "sample", name: "Pretzels", category: "Snacks", price: 1.99, inventory: 30, description: "This is a placeholder description.", selectedNum: 0), Product(image: "sample", name: "Nuts", category: "Snacks", price: 1.99, inventory: 30, description: "This is a placeholder description.", selectedNum: 0)],
        [Product(image: "sample", name: "Blood Orange Juice", category: "Beverages", price: 1.99, inventory: 30, description: "This is a placeholder description.", selectedNum: 0), Product(image: "sample", name: "Tangerine Juice", category: "Beverages", price: 1.99, inventory: 30, description: "This is a placeholder description.", selectedNum: 0), Product(image: "sample", name: "Water", category: "Beverages", price: 1.99, inventory: 30, description: "This is a placeholder description.", selectedNum: 0)],
        [Product(image: "sample", name: "Ketchup", category: "Condiments", price: 1.99, inventory: 30, description: "This is a placeholder description.", selectedNum: 0), Product(image: "sample", name: "Mustard", category: "Condiments", price: 1.99, inventory: 30, description: "This is a placeholder description.", selectedNum: 0), Product(image: "sample", name: "Hot Sauce", category: "Condiments", price: 1.99, inventory: 30, description: "This is a placeholder description.", selectedNum: 0)]
    ]
    
    // constants
    let itemPadding: CGFloat = 10
    let sectionPadding: CGFloat = 5
    let filterHeight: CGFloat = 100
    let cellReuseID = "cellReuseID"
    let headerReuseID = "headerReuseID"
    let filterReuseID = "filterReuseID"
    let collectionViewTag = 0
    let filterCollectionViewTag = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Today's Inventory"
        view.backgroundColor = .white
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = itemPadding
        flowLayout.minimumLineSpacing = itemPadding
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: sectionPadding, left: sectionPadding, bottom: sectionPadding, right: sectionPadding)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseID)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.tag = collectionViewTag
        view.addSubview(collectionView)
        
        collectionView.register(ProductCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerReuseID)
        
        let filterFlowLayout = UICollectionViewFlowLayout()
        filterFlowLayout.minimumInteritemSpacing = itemPadding
        filterFlowLayout.minimumLineSpacing = itemPadding
        filterFlowLayout.scrollDirection = .horizontal
        filterFlowLayout.sectionInset = UIEdgeInsets(top: sectionPadding, left: sectionPadding, bottom: sectionPadding, right: sectionPadding)
        
        filterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: filterFlowLayout)
        filterCollectionView.translatesAutoresizingMaskIntoConstraints = false
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
        filterCollectionView.tag = filterCollectionViewTag
        filterCollectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: filterReuseID)
        view.addSubview(filterCollectionView)
        
        setUpConstraints()
    }

    func setUpConstraints() {
        let collectionViewPadding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: filterCollectionView.bottomAnchor, constant: collectionViewPadding),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: collectionViewPadding),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -collectionViewPadding),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -collectionViewPadding),
        ])
        
        NSLayoutConstraint.activate([
            filterCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            filterCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: collectionViewPadding),
            filterCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -collectionViewPadding),
            filterCollectionView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    // filter algorithm
    func filterProducts(val: Int, filterID: Int) {
        if (filters[val].selected) {
            selectedFilters.append(filterID)
        } else {
            if let i = selectedFilters.firstIndex(of: filterID) {
                selectedFilters.remove(at: i)
            }
        }
        selectedFilters.sort()
        if (selectedFilters.count == 0) {
            products = initialProducts
            sections = initialSections
        } else {
            products = []
            sections = []
            for filter in selectedFilters {
                products.append(initialProducts[filter])
                sections.append(initialSections[filter])
            }
        }
        collectionView.reloadData()
    }
}


extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView.tag == collectionViewTag){
            return products[section].count
        }
        return filters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView.tag == collectionViewTag) {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseID, for: indexPath) as? ProductCollectionViewCell {
                let product = products[indexPath.section][indexPath.item]
                cell.update(product: product)
                return cell
            }
        } else {
            if let cell = filterCollectionView.dequeueReusableCell(withReuseIdentifier: filterReuseID, for: indexPath) as? FilterCollectionViewCell {
                let filter = filters[indexPath.item]
                cell.configure(filterName: filter.name, isSelected: filter.selected)
                return cell
            }
        }
        return UICollectionViewCell()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if (collectionView.tag == collectionViewTag) {
            return products.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (collectionView.tag == collectionViewTag) {
            if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReuseID, for: indexPath) as? ProductCollectionViewHeader {
                header.configure(section: sections[indexPath.section])
                return header
            }
        }
        return UICollectionReusableView()
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView.tag == collectionViewTag) {
            let len = (view.frame.width - 2 * itemPadding - sectionPadding - 30) / 2
            return CGSize(width: len, height: len + 10)
        } else {
            let width = view.frame.width / 5
            return CGSize(width: width, height: 45)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if (collectionView.tag == collectionViewTag) {
            return CGSize(width: self.view.frame.width, height: 50)
        }
        return CGSize(width: 0, height: 0)
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // filter feature
        if (collectionView.tag == filterCollectionViewTag) {
            filters[indexPath.item].setSelected()
            let currentFilter = filters[indexPath.item]
            if let cell = collectionView.cellForItem(at: indexPath) as? FilterCollectionViewCell {
                cell.configure(filterName: currentFilter.name, isSelected: currentFilter.selected)
            }
            filterProducts(val: indexPath.item, filterID: currentFilter.id)
        } else {
            // TODO: redirect users to product details page
            self.navigationController?.pushViewController(DetailsViewController(product: products[indexPath.section][indexPath.item]), animated: true)
        }
    }
}


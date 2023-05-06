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
    let refreshControl = UIRefreshControl()
    
    // sample data initialization
    private var filters: [Filter] = [Filter(name: "Produce", selected: false, id: 0), Filter(name: "Dairy", selected: false, id: 1), Filter(name: "Meat", selected: false, id: 2), Filter(name: "Snacks", selected: false, id: 3), Filter(name: "Beverages", selected: false, id: 4), Filter(name: "Condiments", selected: false, id: 5)]
    private var selectedFilters: [Int] = [] // selected filter ids
    
    private let initialSections = ["Produce", "Dairy", "Meat", "Snacks", "Beverages", "Condiments"]
    private var sections = ["Produce", "Dairy", "Meat", "Snacks", "Beverages", "Condiments"]
    
    private var initialProducts: [[Product]] = [
        [Product(id: 1, image: "1", name: "Apples", category: 1, price: 2.99, description: "This is a placeholder description. This is a placeholder description. This is a placeholder description. This is a placeholder description. This is a placeholder description. This is a placeholder description. This is a placeholder description. This is a placeholder description. This is a placeholder description. This is a placeholder description. This is a placeholder description. This is a placeholder description. This is a placeholder description. This is a placeholder description. This is a placeholder description.This is a placeholder description. This is a placeholder description. This is a placeholder description. This is a placeholder description. This is a placeholder description. This is a placeholder description. This is a placeholder description. This is a placeholder description. This is a placeholder description. This is a placeholder description. ", selectedNum: 0), Product(id: 2, image: "2", name: "Bananas", category: 1, price: 1.99, description: "This is a placeholder description.", selectedNum: 0), Product(id: 3, image: "3", name: "Oranges", category: 1, price: 1.99, description: "This is a placeholder description.", selectedNum: 0)],
        [Product(id: 4, image: "4", name: "Milk", category: 2, price: 1.99, description: "This is a placeholder description.", selectedNum: 0), Product(id: 5, image: "5", name: "Cheese", category: 2, price: 1.99, description: "This is a placeholder description.", selectedNum: 0), Product(id: 6, image: "6", name: "Yogurt", category: 2, price: 1.99, description: "This is a placeholder description.", selectedNum: 0), Product(id: 7, image: "7", name: "Eggs", category: 2, price: 1.99, description: "This is a placeholder description.", selectedNum: 0)],
        [Product(id: 8, image: "8", name: "Sausage", category: 3, price: 1.99, description: "This is a placeholder description.", selectedNum: 0), Product(id: 9, image: "9", name: "Beef", category: 3, price: 1.99, description: "This is a placeholder description.", selectedNum: 0)],
        [Product(id: 10, image: "10", name: "Chips", category: 4, price: 1.99, description: "This is a placeholder description.", selectedNum: 0), Product(id: 11, image: "11", name: "Pretzels", category: 4, price: 1.99, description: "This is a placeholder description.", selectedNum: 0), Product(id: 12, image: "12", name: "Nuts", category: 4, price: 1.99, description: "This is a placeholder description.", selectedNum: 0)],
        [Product(id: 13, image: "13", name: "Blood Orange Juice", category: 5, price: 1.99, description: "This is a placeholder description.", selectedNum: 0), Product(id: 14, image: "14", name: "Tangerine Juice", category: 5, price: 1.99, description: "This is a placeholder description.", selectedNum: 0), Product(id: 15, image: "15", name: "Water", category: 5, price: 1.99, description: "This is a placeholder description.", selectedNum: 0)],
        [Product(id: 16, image: "16", name: "Ketchup", category: 6, price: 1.99, description: "This is a placeholder description.", selectedNum: 0), Product(id: 17, image: "17", name: "Mustard", category: 6, price: 1.99, description: "This is a placeholder description.", selectedNum: 0), Product(id: 18, image: "18", name: "Hot Sauce", category: 6, price: 1.99, description: "This is a placeholder description.", selectedNum: 0)]
    ]
    
    private var shownProducts: [[Product]] = [[]]
    
    // constants
    let itemPadding: CGFloat = 10
    let sectionPadding: CGFloat = 5
    let filterHeight: CGFloat = 100
    let cellReuseID = "cellReuseID"
    let headerReuseID = "headerReuseID"
    let filterReuseID = "filterReuseID"
    let collectionViewTag = 0
    let filterCollectionViewTag = 1
    
    var dummyData: [Product] = []
    var shownDummyData: [Product] = []

    override func viewDidLoad() {
        super.viewDidLoad()
                
        var url = URL(string: "http://127.0.0.1:8002/inventories/")!
        let formatParameter = URLQueryItem(name: "format", value: "json")
        url.append(queryItems: [formatParameter])
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        title = "Products"
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
        if #available(iOS 10.0, *) {
            collectionView.refreshControl = refreshControl
        } else {
            collectionView.addSubview(refreshControl)
        }
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
        filterCollectionView.showsHorizontalScrollIndicator = false
        view.addSubview(filterCollectionView)
        
        createDummyData()
        setUpConstraints()
        
        

    }
    
    //func createDummyData() -> [[Product]] {
//    func createDummyData() -> [[Product]]{
//
//        NetworkManager.shared.getAllProducts { products in
//            DispatchQueue.main.async {
//                self.shownDummyData = products
//                self.collectionView.reloadData()
//                var result = [[Product]]()
//                for i in 0..<self.initialSections.count {
//                    result.append([])
//                }
//                for p in self.shownDummyData {
//                    result[p.category-1].append(p)
//                }
//                return result
//            }
//        }
//    }
    func createDummyData() {
        
        NetworkManager.shared.getAllProducts { products in
            DispatchQueue.main.async {
                self.shownDummyData = products
                for _ in 0..<self.initialSections.count-1 {
                    self.shownProducts.append([])
                }
                for p in self.shownDummyData {
                    self.shownProducts[p.category-1].append(p)
                }
                for i in 0..<self.shownProducts.count {
                    for j in 0..<self.shownProducts[i].count {
                        self.shownProducts[i][j].selectedNum = 0
                    }
                }
                Utilities.updateProductsFromUserDefaults(newProducts: self.shownProducts)
                self.collectionView.reloadData()
            }
        }
    }
    
        
    @objc func refreshData() {
        NetworkManager.shared.getAllProducts { products in
            DispatchQueue.main.async {
                self.shownDummyData = products
                self.collectionView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
        
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
            Utilities.updateProductsFromUserDefaults(newProducts: initialProducts)
            sections = initialSections
        } else {
            var products : [[Product]] = []
            sections = []
            for filter in selectedFilters {
                products.append(initialProducts[filter])
                sections.append(initialSections[filter])
            }
            Utilities.updateProductsFromUserDefaults(newProducts: products)
        }
        collectionView.reloadData()
    }
}


extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView.tag == collectionViewTag){
            let products = Utilities.getProductsFromUserDefaults()
            return products[section].count
        }
        return filters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView.tag == collectionViewTag) {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseID, for: indexPath) as? ProductCollectionViewCell {
                let products = Utilities.getProductsFromUserDefaults()
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
            let products = Utilities.getProductsFromUserDefaults()
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
            // tag width determined by content width
            let label = UILabel()
            label.text = filters[indexPath.row].name
            label.sizeToFit()
            return CGSize(width: label.frame.width + 20, height: 45) // padding: 20
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
            // redirect users to product details page
            let products = Utilities.getProductsFromUserDefaults()
            self.navigationController?.pushViewController(DetailsViewController(products: products, row: indexPath.section, col: indexPath.item), animated: true)
        }
    }
}


//
//  ReservationViewController.swift
//  AnabelsGrocery
//
//  Created by Phyllis Ju on 5/2/23.
//

import UIKit

class ReservationViewController: UIViewController, ShoppingCartViewControllerDelegate {

    
    var totalPrice : Float = 0.0
    var itemsInOrder = [Product]()
    let pickupLabel = UILabel()
    let addressLabel = UILabel()
    let hoursLabel = UILabel()
    let priceLabel = UILabel()
    let cancelBtn = UIButton()
    let stackView = UIStackView()
    
    let cellReuseID = "cellReuseID"
    
    func passDataToReservation(data: [Product]) {
        itemsInOrder = data
    }
    
    init(itemsInOrder: [Product]) {
        self.itemsInOrder = itemsInOrder
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    lazy var collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumInteritemSpacing = 10
            
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.backgroundColor = .white
            collectionView.delegate = self
            collectionView.dataSource = self
            
            collectionView.register(ReservationCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseID)
            
            return collectionView
        }()
    // TODO: Add a tableview of reserved items

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Reservation"
        view.backgroundColor = .white
        
        pickupLabel.font = .systemFont(ofSize: 15)
        pickupLabel.textColor = .black
        pickupLabel.text = "Your reservation is successful! Please pick up in 2 hours and purchase at the counter."
        pickupLabel.lineBreakMode = .byWordWrapping
        pickupLabel.numberOfLines = 0
        pickupLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pickupLabel)
        
        addressLabel.font = .systemFont(ofSize: 15)
        addressLabel.textColor = .black
        addressLabel.text = "Address: Anabel Taylor Hall Room 127, 548 College Ave, Ithaca, NY 14853"
        addressLabel.lineBreakMode = .byWordWrapping
        addressLabel.numberOfLines = 0
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addressLabel)
        
        hoursLabel.font = .systemFont(ofSize: 15)
        hoursLabel.textColor = .black
        hoursLabel.text = "Hours: Wed - Fri: 12-7PM, Sat: 12PM-3PM"
        hoursLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hoursLabel)
        
        priceLabel.font = .boldSystemFont(ofSize: 25)
        priceLabel.textColor = .black
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(priceLabel)
        
        cancelBtn.setTitle("Cancel Reservation", for: .normal)
        cancelBtn.backgroundColor = .systemRed
        cancelBtn.layer.cornerRadius = 10.0
        cancelBtn.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        cancelBtn.setTitleColor(.white, for: .normal)
        cancelBtn.setContentHuggingPriority(.required, for: .horizontal)
        cancelBtn.addTarget(self, action: #selector(onCancel), for: .touchUpInside)
        cancelBtn.translatesAutoresizingMaskIntoConstraints = false
        
        let spacerView = UIView()
        spacerView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        spacerView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(spacerView)
        stackView.addArrangedSubview(cancelBtn)
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        view.addSubview(collectionView)
        updateCollectionView(data: itemsInOrder)
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        totalPrice = UserDefaults.standard.float(forKey: "totalPrice")
        priceLabel.text = "Total Price: " + String(format: "$%.2f", totalPrice)
        itemsInOrder = Utilities.getReservationFromUserDefaults()
        collectionView.reloadData()
    }
    
    @objc func onCancel() {
        // TODO: delete request
    }
    
    func updateCollectionView(data: [Product]) {
        itemsInOrder = data
        collectionView.reloadData()
    }
    
    
    func setupConstraints() {
        let padding = 16.0
        
        NSLayoutConstraint.activate([
            pickupLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            pickupLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            pickupLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            pickupLabel.bottomAnchor.constraint(equalTo: addressLabel.topAnchor, constant: -padding)
        ])
        
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(equalTo: pickupLabel.bottomAnchor, constant: padding),
            addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            addressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            addressLabel.bottomAnchor.constraint(equalTo: hoursLabel.topAnchor, constant: -padding)
        ])
        
        NSLayoutConstraint.activate([
            hoursLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: padding),
            hoursLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            hoursLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            hoursLabel.bottomAnchor.constraint(equalTo: priceLabel.topAnchor, constant: -padding)
        ])
        
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: hoursLabel.bottomAnchor, constant: padding),
            priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            priceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
        ])
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            collectionView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: padding),
            collectionView.heightAnchor.constraint(equalToConstant: 180)
        ])
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }

}

extension ReservationViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsInOrder.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseID, for: indexPath) as! ReservationCollectionViewCell
            
            let product = itemsInOrder[indexPath.item]
            cell.update(product: product)
            
            return cell
        }
}

extension ReservationViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let len = (view.frame.width - 2 * 10 - 5 - 30) / 2
            return CGSize(width: len, height: len+10)
    }
}

//extension ReservationViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//    }
//}

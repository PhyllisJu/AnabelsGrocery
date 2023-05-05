//
//  ReservationViewController.swift
//  AnabelsGrocery
//
//  Created by Phyllis Ju on 5/2/23.
//

import UIKit

class ReservationViewController: UIViewController {
    var totalPrice : Float = 0.0
    let pickupLabel = UILabel()
    let addressLabel = UILabel()
    let hoursLabel = UILabel()
    let priceLabel = UILabel()
    let cancelBtn = UIButton()
    let stackView = UIStackView()
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
//        stackView.backgroundColor = .systemGray6
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        totalPrice = UserDefaults.standard.float(forKey: "totalPrice")
        priceLabel.text = "Total Price: " + String(format: "$%.2f", totalPrice)
    }
    
    @objc func onCancel() {
        // TODO: delete request
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
//            hoursLabel.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -padding)
        ])
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
//            stackView.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: padding),
            stackView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }

}

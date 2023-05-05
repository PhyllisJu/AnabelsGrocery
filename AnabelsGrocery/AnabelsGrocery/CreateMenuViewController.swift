//
//  CreateMenuViewController.swift
//  AnabelsGrocery
//
//  Created by Phyllis Ju on 5/4/23.
//

import UIKit

class CreateMenuViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let nameLabel = UILabel()
    let nameWarningLabel = UILabel()
    let nameTextField = UITextField()
    
    let imageLabel = UILabel()
    let imageWarningLabel = UILabel()
    let chooseImageButton = UIButton()
    let imagePicker = UIImagePickerController()
    let imageView = UIImageView()
    
    let descriptionLabel = UILabel()
    let descriptionWarningLabel = UILabel()
    let descriptionTextView = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Create Recipe"
        view.backgroundColor = .white
        
        let postBarButton = UIBarButtonItem(title: "Post", style: .plain, target: self, action: #selector(onPost))
        navigationItem.rightBarButtonItem = postBarButton
        
        nameLabel.text = "Recipe Name *"
        nameLabel.font = .boldSystemFont(ofSize: 16)
        nameLabel.textColor = .black
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        nameWarningLabel.text = "This field is required."
        nameWarningLabel.textColor = .clear
//        nameWarningLabel.textColor = .systemRed
        nameWarningLabel.translatesAutoresizingMaskIntoConstraints = false
        nameWarningLabel.font = .systemFont(ofSize: 14)
        view.addSubview(nameWarningLabel)
        
        nameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: nameTextField.frame.height))
        nameTextField.leftViewMode = .always
        nameTextField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: nameTextField.frame.height))
        nameTextField.rightViewMode = .always
        nameTextField.placeholder = "e.g., Banana Pancakes"
        nameTextField.layer.cornerRadius = 24
        nameTextField.adjustsFontSizeToFitWidth = true
        nameTextField.font = .systemFont(ofSize: 14)
        nameTextField.textColor = .black
        nameTextField.backgroundColor = .systemGray6
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameTextField)
        
        imageLabel.text = "Upload An Image *"
        imageLabel.font = .boldSystemFont(ofSize: 16)
        imageLabel.textColor = .black
        imageLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageLabel)
        
        imageWarningLabel.text = "This field is required."
        imageWarningLabel.textColor = .clear
//        imageWarningLabel.textColor = .systemRed
        imageWarningLabel.translatesAutoresizingMaskIntoConstraints = false
        imageWarningLabel.font = .systemFont(ofSize: 14)
        view.addSubview(imageWarningLabel)
        
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        chooseImageButton.setTitle("+", for: .normal)
        chooseImageButton.addTarget(self, action: #selector(onChooseButton), for: .touchUpInside)
        chooseImageButton.titleLabel?.font = .systemFont(ofSize: 30)
        chooseImageButton.setTitleColor(.white, for: .normal)
        chooseImageButton.backgroundColor = Utilities.hexStringToUIColor(hex: "#2C3684")
        chooseImageButton.layer.cornerRadius = 5.0
        chooseImageButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(chooseImageButton)
        
        descriptionLabel.text = "Instructions *"
        descriptionLabel.font = .boldSystemFont(ofSize: 16)
        descriptionLabel.textColor = .black
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionLabel)
        
        descriptionWarningLabel.text = "This field is required."
        descriptionWarningLabel.textColor = .clear
//        descriptionWarningLabel.textColor = .systemRed
        descriptionWarningLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionWarningLabel.font = .systemFont(ofSize: 14)
        view.addSubview(descriptionWarningLabel)
        
        descriptionTextView.layer.cornerRadius = 24
        descriptionTextView.font = .systemFont(ofSize: 14)
        descriptionTextView.textColor = .black
        descriptionTextView.backgroundColor = .systemGray6
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.contentInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        view.addSubview(descriptionTextView)
        
        setupConstraints()
    }
    
    @objc func onChooseButton() {
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            imageView.image = pickedImage
            // TODO: Handle image upload here
        }
        dismiss(animated: true)
    }
    
    @objc func onPost() {
        if let nameInput = nameTextField.text,
           let descriptionInput = descriptionTextView.text {
            if (nameInput != "") {
                nameWarningLabel.textColor = .clear
            } else {
                nameWarningLabel.textColor = .systemRed
            }
            if (descriptionInput != "") {
                descriptionWarningLabel.textColor = .clear
            } else {
                descriptionWarningLabel.textColor = .systemRed
            }
        }
        
        if imageView.image == nil {
            imageWarningLabel.textColor = .systemRed
        } else {
            imageWarningLabel.textColor = .clear
        }
        
        // TODO: make a post request to add this menu
    }
    
    func setupConstraints() {
        let padding : CGFloat = 16.0
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding)
        ])
        
        NSLayoutConstraint.activate([
            nameWarningLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            nameWarningLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: padding)
        ])
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: padding),
            nameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            nameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            nameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            imageLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: padding),
            imageLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding)
        ])
        
        NSLayoutConstraint.activate([
            imageWarningLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: padding),
            imageWarningLabel.leadingAnchor.constraint(equalTo: imageLabel.trailingAnchor, constant: padding)
        ])
        
        NSLayoutConstraint.activate([
            chooseImageButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: padding),
            chooseImageButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            chooseImageButton.widthAnchor.constraint(equalToConstant: 35),
            chooseImageButton.heightAnchor.constraint(equalToConstant: 35),
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: imageLabel.bottomAnchor, constant: padding),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: padding),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding)
        ])
        
        NSLayoutConstraint.activate([
            descriptionWarningLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: padding),
            descriptionWarningLabel.leadingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor, constant: padding)
        ])
        
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: padding),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            descriptionTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding)
        ])
    }
}

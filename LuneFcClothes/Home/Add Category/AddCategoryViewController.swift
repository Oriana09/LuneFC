//
//  AddCategoryViewController.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 11/03/2024.
//

import Foundation
import UIKit
import RealmSwift

class AddCategoryViewController: UIViewController, UINavigationControllerDelegate {
    
    private let viewModel: AddCategoryViewModel
    
    private lazy var productImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Nombre de la categoria"
        textField.font = .systemFont(ofSize: 20)
        textField.borderStyle = .roundedRect
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var addPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Agregar Foto", for: .normal)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(addPhoto), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var addCategoryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Agregar categoria", for: .normal)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(addCategory), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.setupConstraints()
        
    }
    
    init(viewModel: AddCategoryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        self.view.addSubviews(
            self.productImage,
            self.nameTextField,
            self.addPhotoButton,
            self.addCategoryButton
        )
        
        NSLayoutConstraint.activate([
            
            self.productImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.productImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.productImage.widthAnchor.constraint(equalToConstant: 150),
            self.productImage.heightAnchor.constraint(equalToConstant: 150),
            
            self.nameTextField.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 20),
            self.nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            self.nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            self.addPhotoButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            self.addPhotoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            self.addPhotoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            self.addCategoryButton.topAnchor.constraint(equalTo: self.addPhotoButton.bottomAnchor, constant: 20),
            self.addCategoryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            self.addCategoryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            
        ])
    }
    
    
    @objc private func addPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc private func addCategory() {
        guard let nombre = nameTextField.text else {
            
            return
        }
       
        viewModel.saveCategory(name: nombre, image: productImage.image?.pngData())
        

        navigationController?.popViewController(animated: true)
    }
}
    extension AddCategoryViewController: UIImagePickerControllerDelegate {
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            picker.dismiss(animated: true, completion: nil)
            guard let image = info[.originalImage] as? UIImage else {
                // Manejar el caso cuando no se selecciona una imagen válida
                return
            }
            productImage.image = image
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
    }
    


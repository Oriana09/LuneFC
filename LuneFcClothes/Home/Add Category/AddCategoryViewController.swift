//
//  AddCategoryViewController.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 11/03/2024.
//

import Foundation
import UIKit

protocol AddCategoryPresenterDelegate: AnyObject {
    func onDismiss()
}

class AddCategoryViewController: UIViewController, UINavigationControllerDelegate {
    
    private lazy var productImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "categoryPlaceholder")
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(imageTapped)
        )
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Nombre de la categoria"
        textField.font = .systemFont(ofSize: 20)
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 10
        textField.layer.masksToBounds = true
        textField.textColor = ColorManager.light_neutral_1000_dark_neutral_1000
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tintColor = ColorManager.button_primary_blue_light_button_prmary_blue_dark
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.addTarget(self, action: #selector(deleteImage), for: .touchUpInside)
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    let padding: CGFloat = 16.0
    let nameTextPadding: CGFloat = 20.0
    
    private let viewModel: AddCategoryViewModel
    weak var delegate: AddCategoryPresenterDelegate?
    
    init(viewModel: AddCategoryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor =  ColorManager.light_neutral_50_dark_neutral_100
        self.navigationItem.title = "Nueva Categoria"
        self.setupConstraints()
        self.cancelButtom()
        self.addCategoryButton()
    }
    
    private func cancelButtom(){
        
        let addButton =  UIBarButtonItem(
            title: "Cancel",
            style: .plain,
            target: self,
            action: #selector(cancelButton)
            
        )
        addButton.tintColor = ColorManager.button_primary_blue_light_button_prmary_blue_dark
        navigationItem.leftBarButtonItem = addButton
    }
    
    @objc func cancelButton() {
        self.confirmationAlert()
    }
    
    private func addCategoryButton(){
        
        let addCategoryButton =  UIBarButtonItem(
            title: "Agregar",
            style: .plain,
            target: self,
            action: #selector(addCategory)
        )
        
        addCategoryButton.tintColor = ColorManager.button_primary_blue_light_button_prmary_blue_dark
        navigationItem.rightBarButtonItem = addCategoryButton
    }
    
    @objc private func addCategory() {
        
        guard let nombre = nameTextField.text else {
#warning("agregar alerta de qur faltan parametros")
            return
        }
        
        self.viewModel.saveCategory(
            name: nombre,
            image: self.productImage.image?.pngData(), 
            sizes:
        )
        
        self.dismiss()
    }
    
    private func dismiss() {
        self.delegate?.onDismiss()
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setupConstraints() {
        self.view.addSubviews(
            self.productImage,
            self.nameTextField,
            self.deleteButton
        )
        
        NSLayoutConstraint.activate([
            self.productImage.topAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                constant: padding
            ),
            self.productImage.leadingAnchor.constraint(
                equalTo: self.view.leadingAnchor,
                constant: padding
            ),
            self.productImage.trailingAnchor.constraint(
                equalTo: self.view.trailingAnchor,
                constant: -padding
            ),
            self.productImage.heightAnchor.constraint(
                equalToConstant: 250
            ),
            
            self.nameTextField.topAnchor.constraint(
                equalTo: self.productImage.bottomAnchor,
                constant: nameTextPadding
            ),
            self.nameTextField.leadingAnchor.constraint(
                equalTo: self.view.leadingAnchor,
                constant: nameTextPadding
            ),
            self.nameTextField.trailingAnchor.constraint(
                equalTo: self.view.trailingAnchor,
                constant: -nameTextPadding
            ),
            self.nameTextField.heightAnchor.constraint(
                equalToConstant: 50.0
            ),
            
            self.deleteButton.topAnchor.constraint(
                equalTo: self.productImage.topAnchor
            ),
            self.deleteButton.trailingAnchor.constraint(
                equalTo: self.productImage.trailingAnchor,
                constant: -16.0
            ),
            
            self.deleteButton.heightAnchor.constraint(
                equalToConstant: 50.0
            )
        ])
    }
    
    private func confirmationAlert() {
        let alert = UIAlertController(title: "¿Estás segura?", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Sí", style: .default, handler: { _ in
            
            self.dismiss()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func imageTapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc func deleteImage() {
        if self.productImage.image != UIImage(named: "categoryPlaceholder") {
            self.productImage.image = UIImage(named: "categoryPlaceholder")
            self.deleteButton.isHidden = true
        }
    }
}

//MARK: - UIImagePickerControllerDelegate

extension AddCategoryViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info[.originalImage] as? UIImage {
            self.productImage.image = image
            self.deleteButton.isHidden = false
        } else {
            print("Error: Could not get selected image")
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}



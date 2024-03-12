//
//  AddElementViewController.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 11/03/2024.
//

import Foundation
import UIKit

class AddElementViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Declaración de propiedades
    private lazy var productImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nombreTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Nombre del elemento"
        textField.font = .systemFont(ofSize: 20)
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var agregarFotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Agregar Foto", for: .normal)
        button.addTarget(self, action: #selector(agregarFoto), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Método viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(productImage)
        view.addSubview(nombreTextField)
        view.addSubview(agregarFotoButton)
        
        setupConstraints()
    }
    
    // Método para configurar las restricciones de los elementos de la interfaz de usuario
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Product Image constraint
            productImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            productImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            productImage.widthAnchor.constraint(equalToConstant: 150),
            productImage.heightAnchor.constraint(equalToConstant: 150),
            
            // Nombre TextField constraint
            nombreTextField.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 20),
            nombreTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nombreTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Agregar Foto Button constraint
            agregarFotoButton.topAnchor.constraint(equalTo: nombreTextField.bottomAnchor, constant: 20),
            agregarFotoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            agregarFotoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    // Acción del botón agregarFoto
    @objc private func agregarFoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    // Método del delegado UIImagePickerControllerDelegate
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

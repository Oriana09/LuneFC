//
//  AddClothingListViewController.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 08/04/2024.
//

import UIKit

class AddClothingListViewController: UIViewController {
    
    private lazy var productImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private  lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textColor = ColorManager.light_neutral_1000_dark_neutral_1000
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font          = .systemFont(ofSize: 30, weight: .bold)
        label.numberOfLines = 0
        label.textColor = ColorManager.light_neutral_1000_dark_neutral_1000
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var sizeView: SizeView = {
        let view = SizeView(sizes: []) // Aquí debes pasar los tamaños correspondientes
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let tallasPorGrupo: [String: [String]] = [
        "groupLetters": ["XS", "S", "M", "L", "XL", "XXL"],
        "groupNumbers": ["36", "38", "40", "42", "44", "46", "48"]
    ]
    
    private let ViewModel: AddClothingListViewModel
    
    init(ViewModel: AddClothingListViewModel) {
        self.ViewModel = ViewModel
        super.init(nibName: nil, bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    private func confirmationAlert() {
        let alert = UIAlertController(title: "¿Estás segura?", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Sí", style: .default, handler: { _ in
         
       //     self.dismiss()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
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
      
        
//        guard let nombre = nameTextField.text else {
//#warning("agregar alerta de qur faltan parametros")
//            return
//        }
        
//        self.viewModel.saveCategory(
//            name: nombre,
//            image: self.productImage.image?.pngData()
//        )
        
//        self.dismiss()
    }
}

//
//  AddNameTableViewCell.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 10/04/2024.
//

import Foundation
import UIKit

class AddNameTableViewCell: UITableViewCell {
    
    static let identifier = "AddNameTableViewCell"
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupConstraints() {
        self.contentView.addSubview(self.nameTextField)
        #warning("configurar las constraints")
        NSLayoutConstraint.activate([
        
//            self.nameTextField.topAnchor.constraint(
//                equalTo: self.productImage.bottomAnchor,
//                constant: nameTextPadding
//            ),
//            self.nameTextField.leadingAnchor.constraint(
//                equalTo: self.contentView.leadingAnchor,
//                constant: nameTextPadding
//            ),
//            self.nameTextField.trailingAnchor.constraint(
//                equalTo: self.contentView.trailingAnchor,
//                constant: -nameTextPadding
//            ),
//            self.nameTextField.heightAnchor.constraint(
//                equalToConstant: 50.0
//            ),
            
        
        ])
    }
    
}

////
////  AddImageTableViewCell.swift
////  LuneFcClothes
////
////  Created by Oriana Costancio on 09/04/2024.
////
//#warning("tengo que configurar la celda con el model")
//
//#warning(" primero que todo, crear la celda de AddCategory")
//import Foundation
//import UIKit
//
//class AddImageTableViewCell: UITableViewCell, UINavigationControllerDelegate {
// 
//    static let identifier = "AddImageTableViewCell"
//    
//    private lazy var productImage: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFill
//        imageView.layer.cornerRadius = 10
//        imageView.layer.masksToBounds = true
//        imageView.image = UIImage(named: "categoryPlaceholder")
//        let tapGesture = UITapGestureRecognizer(
//            target: self,
//            action: #selector(imageTapped)
//        )
//        imageView.isUserInteractionEnabled = true
//        imageView.addGestureRecognizer(tapGesture)
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
//    
//    private lazy var deleteButton: UIButton = {
//        let button = UIButton(type: .custom)
//        button.tintColor = ColorManager.button_primary_blue_light_button_prmary_blue_dark
//        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
//        button.addTarget(self, action: #selector(deleteImage), for: .touchUpInside)
//        button.isHidden = true
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//    
//    let padding: CGFloat = 16.0
//    let nameTextPadding: CGFloat = 20.0
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        
//        self.setupConstraints()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupConstraints() {
//        self.contentView.addSubviews(
//            self.productImage,
//            self.deleteButton
//        )
//        
//        NSLayoutConstraint.activate([
//            self.productImage.topAnchor.constraint(
//                equalTo: self.contentView.safeAreaLayoutGuide.topAnchor,
//                constant: padding
//            ),
//            self.productImage.leadingAnchor.constraint(
//                equalTo: self.contentView.leadingAnchor,
//                constant: padding
//            ),
//            self.productImage.trailingAnchor.constraint(
//                equalTo: self.contentView.trailingAnchor,
//                constant: -padding
//            ),
//            self.productImage.heightAnchor.constraint(
//                equalToConstant: 250
//            ),
//            
//           
//            self.deleteButton.topAnchor.constraint(
//                equalTo: self.productImage.topAnchor
//            ),
//            self.deleteButton.trailingAnchor.constraint(
//                equalTo: self.productImage.trailingAnchor,
//                constant: -16.0
//            ),
//            
//            self.deleteButton.heightAnchor.constraint(
//                equalToConstant: 50.0
//            )
//        ])
//    }
//    
//    @objc func deleteImage() {
//        if self.productImage.image != UIImage(named: "categoryPlaceholder") {
//            self.productImage.image = UIImage(named: "categoryPlaceholder")
//            self.deleteButton.isHidden = true
//        }
//    }
//    
//    func configure(model: Category) {
//        if let data = model.imageData {
//            self.productImage.image = UIImage(data: data)
//        }
//
//    }
//}

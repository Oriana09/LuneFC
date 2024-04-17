//
//  CustumTableViewCell.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 13/04/2024.
//

import Foundation
import UIKit

private extension UIConfigurationStateCustomKey {
    static let productImage = UIConfigurationStateCustomKey("productImage")
    static let deleteButtonHidden = UIConfigurationStateCustomKey("deleteButtonHidden")
}

private extension UICellConfigurationState {
    var productImage: UIImage? {
        get { return self[.productImage] as? UIImage }
        set { self[.productImage] = newValue }
    }
    
    var deleteButtonHidden: Bool {
        get { return self[.deleteButtonHidden] as? Bool ?? false }
        set { self[.deleteButtonHidden] = newValue }
    }
}

class ImagePickerTableViewCell: UITableViewCell {
    
    static let identifier = "CustomTableViewCell"
    
    private lazy var productImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tintColor = ColorManager.button_primary_blue_light_button_prmary_blue_dark
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.addTarget(self, action: #selector(deleteImage), for: .touchUpInside)
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let padding: CGFloat = 16.0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        self.contentView.addSubviews(
            self.productImage,
            self.deleteButton
        )
        
        NSLayoutConstraint.activate([
            self.productImage.topAnchor.constraint(
                equalTo: self.contentView.topAnchor,
                constant: padding
            ),
            self.productImage.leadingAnchor.constraint(
                equalTo: self.contentView.leadingAnchor,
                constant: padding
            ),
            self.productImage.trailingAnchor.constraint(
                equalTo: self.contentView.trailingAnchor,
                constant: -padding
            ),
            self.productImage.heightAnchor.constraint(
                equalToConstant: 300 ),
            
            self.productImage.bottomAnchor.constraint(
                equalTo: self.contentView.bottomAnchor,
                constant: -padding
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
    
    override var configurationState: UICellConfigurationState {
        var state = super.configurationState
        state.productImage = self.productImage.image
        state.deleteButtonHidden = self.deleteButton.isHidden
        return state
    }
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        super.updateConfiguration(using: state)
        
        if let productImage = state.productImage {
            self.productImage.image = productImage
        }
        
        self.deleteButton.isHidden = state.deleteButtonHidden
    }
    
    @objc private func deleteImage() {
        if self.productImage.image != UIImage(named: "photo_placeholder") {
            self.productImage.image = UIImage(named: "photo_placeholder")
            self.deleteButton.isHidden = true
        }
    }
    
    func configure(image: UIImage?) {
        self.productImage.image = image
    }
}

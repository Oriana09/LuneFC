//
//  AddProductTableViewCell.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 12/07/2024.
//

import Foundation
import UIKit

class AddProductTableViewCell: UITableViewCell {
    
    static let identifier = "AddProductTableViewCell"
    
    private lazy var productImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private  lazy var sizeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textColor = ColorManager.light_neutral_1000_dark_neutral_1000
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private  lazy var styleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textColor = ColorManager.light_neutral_1000_dark_neutral_1000
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        self.contentView.addSubviews(
            self.productImage,
            self.sizeLabel,
            self.styleLabel
        )
        
        NSLayoutConstraint.activate([
            
            self.productImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            self.productImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            self.productImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            self.productImage.widthAnchor.constraint(equalToConstant: 150),
            self.productImage.heightAnchor.constraint(equalToConstant: 150),
            
            self.sizeLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            self.sizeLabel.leadingAnchor.constraint(equalTo: self.productImage.trailingAnchor, constant: 16),
            self.sizeLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            
            self.styleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            self.styleLabel.leadingAnchor.constraint(equalTo: self.productImage.trailingAnchor, constant: 16),
            self.styleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            
        ])
    }
    
    func configure(with item: ClothingItem) {
        if let imageData = item.image {
            self.productImage.image = UIImage(data: imageData)
        } else {
            self.productImage.image = nil
        }
    
    }
}

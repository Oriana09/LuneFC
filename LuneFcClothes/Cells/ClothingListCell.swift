//
//  ClothingListCell.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 16/02/2024.
//

import Foundation
import UIKit

class ClothingListCell: UITableViewCell {
    
    static let identifier = "ClothingListCell"
    
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
    
    private  lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font          = .systemFont(ofSize: 20, weight: .bold)
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
            self.nameLabel,
            self.priceLabel
        )
        
        NSLayoutConstraint.activate([
            
            //Product Image constraint
            self.productImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            self.productImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            self.productImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            self.productImage.widthAnchor.constraint(equalToConstant: 150),
            self.productImage.heightAnchor.constraint(equalToConstant: 150),
           
            //nammeLabel constraint
            self.nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            self.nameLabel.leadingAnchor.constraint(equalTo: self.productImage.trailingAnchor, constant: 16),
            self.nameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            
            //priceLabel constraint
            self.priceLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 8),
            self.priceLabel.leadingAnchor.constraint(equalTo: self.productImage.trailingAnchor, constant: 16),
            self.priceLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
        ])
    }
   
    func configure(model: ClothingItem) {
        self.productImage.image =  UIImage(named: model.description)
        self.priceLabel.text = "$\(model.price)"
        self.nameLabel.text = model.title
    }
    
    
}


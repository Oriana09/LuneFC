//
//  ClothingTableViewCell.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 16/02/2024.
//

import Foundation
import UIKit

class ClothingTableViewCell: UITableViewCell {
    
    static let identifier = "ClothingTableViewCell"
    
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
    
    private lazy var sizesBoxView: SizeView = {
        let sizes = SizeView(
            sizes: [
                "38",
                "40",
                "42",
                "44",
                "46"
            ]
        )
        
        sizes.translatesAutoresizingMaskIntoConstraints = false
        return sizes
    }()
    
    private lazy var containerView: BlurContainerView = {
        let container = BlurContainerView(cornerRadius: 10)
        container.layer.masksToBounds = true
        container.translatesAutoresizingMaskIntoConstraints = false
        
        return container
    }()
    
    private  lazy var codeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = ColorManager.light_neutral_1000_dark_neutral_1000
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let padding: CGFloat = 5.0
    
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
            self.priceLabel,
            self.containerView,
            self.codeLabel,
            self.sizesBoxView
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
            self.priceLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            
            self.sizesBoxView.topAnchor.constraint(
                equalTo: self.priceLabel.bottomAnchor,
                constant: 8
            ),
            self.sizesBoxView.leadingAnchor.constraint(
                equalTo: self.productImage.trailingAnchor,
                constant: 16
            ),

            self.containerView.leadingAnchor.constraint(
                equalTo: self.productImage.leadingAnchor
            ),
            self.containerView.trailingAnchor.constraint(
                equalTo: self.productImage.trailingAnchor
            ),
            self.containerView.bottomAnchor.constraint(
                equalTo: self.productImage.bottomAnchor
            ),
            self.containerView.topAnchor.constraint(
                equalTo: self.codeLabel.topAnchor,
                constant: -self.padding
            ),

            self.codeLabel.leadingAnchor.constraint(
                equalTo: self.containerView.leadingAnchor,
                constant: padding
            ),
            self.codeLabel.trailingAnchor.constraint(
                equalTo: self.containerView.trailingAnchor,
                constant: -padding
            ),
            self.codeLabel.bottomAnchor.constraint(
                equalTo: self.productImage.bottomAnchor,
                constant: -padding
            )
        ])
    }
    
    func configure(model: ClothingItem) {
        
        self.priceLabel.text = "$\(model.price)"
        self.nameLabel.text = model.title
        
        self.codeLabel.text = "#\(model.idCode ?? "Sin codigo")"
        
        
        if let data = model.image {
            self.productImage.image = UIImage(data: data)
        }
#warning("Setear placeholder")
        //        self.imageView.image = UIImage(data: model.imageData ?? model.placeholderData)
        self.sizesBoxView.selectButton(withTitle: model.size)
    }
}
    
    



//
//  ClothesCell.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 08/02/2024.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CategoryCollectionViewCell"
    
    private lazy var containerView: BlurContainerView = {
        let container = BlurContainerView(cornerRadius: 10)
        container.layer.masksToBounds = true
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var label: UILabel = {
        let label =  UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = ColorManager.light_neutral_1000_dark_neutral_1000
        label.translatesAutoresizingMaskIntoConstraints =  false
        return label
    }()
    
    let padding: CGFloat = 5.0
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.setContrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setContrains() {
        self.contentView.addSubviews(
            imageView,
            containerView
        )
        self.containerView.addSubview(self.label)
        
        NSLayoutConstraint.activate([
            
            self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            self.containerView.leadingAnchor.constraint(
                equalTo: self.imageView.leadingAnchor
            ),
            self.containerView.trailingAnchor.constraint(
                equalTo: self.imageView.trailingAnchor
            ),
            self.containerView.bottomAnchor.constraint(
                equalTo: self.imageView.bottomAnchor
            ),
            self.containerView.topAnchor.constraint(
                equalTo: self.label.topAnchor,
                constant: -self.padding
            ),
            
            self.label.leadingAnchor.constraint(
                equalTo: self.containerView.leadingAnchor,
                constant: padding
            ),
            self.label.trailingAnchor.constraint(
                equalTo: self.containerView.trailingAnchor,
                constant: -self.padding
            ),
            self.label.bottomAnchor.constraint(
                equalTo: self.imageView.bottomAnchor,
                constant: -self.padding
            )
        ])
    }
    
    func configure(model: Category) {
        self.label.text = model.name
        self.imageView.image = UIImage(data: model.imageData ?? Data()) ?? UIImage(named: "CategoryPlaceholder")
    }
}



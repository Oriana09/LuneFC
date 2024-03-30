//
//  ClothesCell.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 08/02/2024.
//

import Foundation
import UIKit

class CategoryCell: UICollectionViewCell {
    
    static let identifier = "CategoryCell"
    
    
    
    private lazy var blurBox: BlurContainer = {
        let container = BlurContainer(cornerRadius: 20)
        container.layer.masksToBounds = true
        container.translatesAutoresizingMaskIntoConstraints = false
        
        return container
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var label: UILabel = {
        let label =  UILabel()
        label.font          = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.textColor = ColorManager.light_neutral_1000_dark_neutral_1000
        label.translatesAutoresizingMaskIntoConstraints =  false
        return label
    }()
    
    
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
        blurBox
        )
        self.blurBox.addSubview(self.label)
        
        NSLayoutConstraint.activate([
            
            self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            self.imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            self.imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5),
            self.imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5),

            self.blurBox.leadingAnchor.constraint(equalTo: self.imageView.leadingAnchor),
            self.blurBox.trailingAnchor.constraint(equalTo: self.imageView.trailingAnchor),
            self.blurBox.bottomAnchor.constraint(equalTo: self.imageView.bottomAnchor),
            self.blurBox.heightAnchor.constraint(equalToConstant: 40),
            
            
            self.label.topAnchor.constraint(equalTo: self.blurBox.topAnchor, constant: 5),
            self.label.leadingAnchor.constraint(equalTo: self.blurBox.leadingAnchor, constant: 5),
            self.label.trailingAnchor.constraint(equalTo: self.blurBox.trailingAnchor, constant: -5)
        ])
    }
    
    func configure(model: Category) {
        self.label.text = model.name
        
        if let data = model.imageData {
            self.imageView.image = UIImage(data: data)
        }
        
        #warning("Setear placeholder")
//        self.imageView.image = UIImage(data: model.imageData ?? model.placeholderData)
    }
}



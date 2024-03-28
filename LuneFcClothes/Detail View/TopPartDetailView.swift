//
//  TopPartDetailView.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 28/02/2024.
//

import Foundation
import UIKit

class TopPartDetailView: UIView {
    
    
    // MARK: - Subviews
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "musculosa")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    private let nameProductLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.text = "muscu"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.text = "Precio"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28, weight: .black)
        label.text = "$40"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        backgroundColor = .white
        
        self.addSubviews(
            imageView,
            nameProductLabel,
            priceLabel,
            priceValueLabel
        )
        
        NSLayoutConstraint.activate([
            
            self.imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.imageView.widthAnchor.constraint(equalToConstant: 200),
            self.imageView.heightAnchor.constraint(equalToConstant: 250),
            
            
            
            self.nameProductLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor),
            self.nameProductLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 16),
            self.nameProductLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -16),
            
            
            self.priceLabel.topAnchor.constraint(equalTo: self.nameProductLabel.bottomAnchor),
            self.priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            self.priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -16),
            
            
            self.priceValueLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 6),
            self.priceValueLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            self.priceValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            self.priceValueLabel.bottomAnchor.constraint(greaterThanOrEqualTo: self.bottomAnchor),
            
        ])
        
//        func configure(model: ClothingItem) {
//            self.nameProductLabel.text = model.title
//            self.priceValueLabel.text = "$\(model.price)"
//            self.imageView.image =  model.image
//            
//        }
//  
    }
    
 
    
}

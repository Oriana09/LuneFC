//
//  TopPartDetailView.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 28/02/2024.
//

import Foundation
import UIKit

class TopPartDetailView: UIView {
    // MARK: - Properties
    private var isAnimating: Bool = false
    var viewModel = ClothingItemViewModel()
    
    // MARK: - Subviews
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.text = "Precio"
        return label
    }()
    
    private let priceValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28, weight: .black)
        
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        startAnimation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        backgroundColor = .white
        
        // Add subviews
        addSubview(priceLabel)
        addSubview(priceValueLabel)
        addSubview(imageView)
        
        // Layout constraints
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceValueLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            priceValueLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 6),
            priceValueLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            imageView.widthAnchor.constraint(equalToConstant: 150) // You may need to adjust this width based on your layout
        ])
        
        func configure(model: ClothingItem) {
            self.imageView.image =  model.image
            self.priceValueLabel.text = "$\(model.price)"
        }
  
    }
    
    // MARK: - Animation
//    func animate() {
//        UIView.animate(withDuration: 0.75) {
//            self.priceLabel.transform = CGAffineTransform(translationX: 0, y: -50)
//            self.priceValueLabel.transform = CGAffineTransform(translationX: 0, y: -75)
//            self.imageView.alpha = 1
//        }
//    }
    func startAnimation() {
        isAnimating = true
        UIView.animate(withDuration: 0.75) {
            self.priceLabel.transform = CGAffineTransform(translationX: 0, y: -50)
            self.priceValueLabel.transform = CGAffineTransform(translationX: 0, y: -75)
            self.imageView.alpha = 1
        }
    }

}

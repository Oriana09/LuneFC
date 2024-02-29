//
//  ColorSize.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 28/02/2024.
//

import Foundation
import UIKit

class ColorSizeView: UIView {
    // MARK: - Properties
    let sizes: [String] = ["XS", "S", "L", "M", "XL"]
    
    // MARK: - Subviews
    private var buttons: [UIButton] = []
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        backgroundColor = .white
        
        var previousButton: UIButton?
        for size in sizes {
            let button = UIButton(type: .system)
            button.setTitle(size, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
            button.setTitleColor(.gray, for: .normal)
            button.backgroundColor = .white
            button.layer.cornerRadius = 5
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor.gray.cgColor
            button.translatesAutoresizingMaskIntoConstraints = false
            addSubview(button)
            buttons.append(button)
            
            NSLayoutConstraint.activate([
                button.heightAnchor.constraint(equalToConstant: 28),
                button.widthAnchor.constraint(equalToConstant: 28),
                button.topAnchor.constraint(equalTo: topAnchor, constant: 20),
                button.leadingAnchor.constraint(equalTo: previousButton?.trailingAnchor ?? leadingAnchor, constant: 10)
            ])
            
            previousButton = button
        }
    }
}

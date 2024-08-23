//
//  Size\CollectionViewCell.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 27/05/2024.
//

import Foundation
import UIKit

class ProductoDetailsCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "AddProductCollectionViewCell"
    
     lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.contentView.layer.cornerRadius = 5
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor.label.cgColor
        self.contentView.layer.shadowOpacity = 0.2
        self.contentView.layer.masksToBounds = false
    }
    
    private func setupConstraints() {
        self.contentView.addSubview(self.label)
        
        NSLayoutConstraint.activate([
    
            self.label.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.label.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.label.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(with size: String, isSelected: Bool) {
        self.label.text = size
        
        guard isSelected else {
            self.contentView.backgroundColor = .clear
            return
        }
        self.contentView.backgroundColor = ColorManager.button_primary_blue_light_button_prmary_blue_dark
    }
}

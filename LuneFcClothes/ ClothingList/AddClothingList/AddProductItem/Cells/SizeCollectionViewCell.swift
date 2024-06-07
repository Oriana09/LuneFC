//
//  Size\CollectionViewCell.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 27/05/2024.
//

import Foundation
import UIKit

class SizeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SizeCollectionViewCell"
    
    private let sizeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
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
        self.contentView.addSubview(self.sizeLabel)
        
        NSLayoutConstraint.activate([
            self.sizeLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.sizeLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
        ])
    }
    
    func configure(with size: String, isSelected: Bool) {
        self.sizeLabel.text = size
        if isSelected {
            self.contentView.backgroundColor = ColorManager.button_primary_blue_light_button_prmary_blue_dark
            
        } else {
            self.contentView.backgroundColor = .clear
        }
    }
}

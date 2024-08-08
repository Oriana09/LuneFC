//
//  Size\CollectionViewCell.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 27/05/2024.
//

import Foundation
import UIKit

class AddProductCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "AddProductCollectionViewCell"
    
    let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
//        label.lineBreakMode = .byTruncatingTail
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
    
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
//            self.label.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
//            self.label.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
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

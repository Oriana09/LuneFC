//
//  AddButtonCollectionViewCell.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 12/06/2024.
//

import Foundation
import UIKit

protocol AddButtonCollectionViewCellDelegate: AnyObject {
    func didTapAddButton(in cell: AddButtonCollectionViewCell)
}

class AddButtonCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "AddButtonCollectionViewCell"
    
    weak var delegate: AddButtonCollectionViewCellDelegate?
    
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.addTarget(AddButtonCollectionViewCell.self, action: #selector(addButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        self.contentView.addSubview(self.addButton)
        
        NSLayoutConstraint.activate([
            self.addButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.addButton.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
        ])
    }
    
    @objc private func addButtonTapped() {
        delegate?.didTapAddButton(in: self)
    }
}

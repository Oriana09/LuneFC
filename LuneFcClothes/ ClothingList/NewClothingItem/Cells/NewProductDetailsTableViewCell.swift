//
//  AddProductTableViewCell.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 12/07/2024.
//

import Foundation
import UIKit

protocol NewProductDetailsTableViewCellDelegate: AnyObject {
    func plusControlDidSelect(for item: ClothingItem)
    func minusControlDidSelect(for item: ClothingItem)
}

class NewProductDetailsTableViewCell: UITableViewCell {
    
    static let identifier = "AddProductTableViewCell"
    
    private lazy var productImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var stackSize: UIStackView = {
        let stack = UIStackView(
        arrangedSubviews: [
            self.sizeLabel,
            self.sizeNumLabel
        ])
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private  lazy var sizeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.text = "Talle:"
        label.numberOfLines = 0
        label.textColor = ColorManager.light_neutral_1000_dark_neutral_1000
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private  lazy var sizeNumLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .right
        label.textColor = ColorManager.light_neutral_1000_dark_neutral_1000
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stackStyle: UIStackView = {
        let stack = UIStackView(
        arrangedSubviews: [
            self.styleLabel,
            self.styleColourLabel
        ])
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private  lazy var styleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.text = "Color:"
        label.textColor = ColorManager.light_neutral_1000_dark_neutral_1000
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private  lazy var styleColourLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .right
        label.textColor = ColorManager.light_neutral_1000_dark_neutral_1000
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stackQuantity: UIStackView = {
        let stack = UIStackView(
        arrangedSubviews: [
            self.quantityStepper,
            self.quantityLabel
        ])
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private lazy var quantityStepper: UIStepper = {
           let stepper = UIStepper()
           stepper.minimumValue = 1
           stepper.maximumValue = 100
           stepper.value = 1
           stepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
        
           stepper.translatesAutoresizingMaskIntoConstraints = false
           return stepper
       }()
    
    private lazy var quantityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .right
        label.text = "1"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stackVertical: UIStackView = {
        let stack = UIStackView(
        arrangedSubviews: [
            self.stackSize,
            self.stackStyle,
            self.stackQuantity
        ])
        stack.axis = .vertical
        stack.spacing = 25
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private var lastStep: Int = 0
    private var item: ClothingItem = ClothingItem()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var delegate: NewProductDetailsTableViewCellDelegate?

    private func setupConstraints() {
        self.contentView.addSubviews(
            self.productImage,
            self.stackVertical
        )
        
        NSLayoutConstraint.activate([
            
            self.productImage.topAnchor.constraint(
                equalTo: self.contentView.topAnchor, constant: 8
            ),
            self.productImage.leadingAnchor.constraint(
                equalTo: self.contentView.leadingAnchor, constant: 8
            ),
            self.productImage.bottomAnchor.constraint(
                equalTo: self.contentView.bottomAnchor, constant: -8
            ),
            self.productImage.widthAnchor.constraint(equalToConstant: 150),
            self.productImage.heightAnchor.constraint(equalToConstant: 150),
           
            self.stackVertical.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            self.stackVertical.leadingAnchor.constraint(equalTo: self.productImage.trailingAnchor, constant: 8),
            self.stackVertical.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8)
            
        ])
    }
    
    @objc private func stepperValueChanged(_ sender: UIStepper) {
        let newValue = Int(sender.value)
        
        if newValue > self.lastStep {
            self.delegate?.plusControlDidSelect(for: self.item)
        } else {
            self.delegate?.minusControlDidSelect(for: self.item)
        }
        
        self.quantityLabel.text = String(newValue)
        self.lastStep = newValue
    }
    
    func configure(with item: ClothingItem, cantOfItems: Int) {
        self.item = item
        if let imageData = item.image {
            self.productImage.image = UIImage(data: imageData)
        } else {
            self.productImage.image = nil
        }
        
        self.sizeNumLabel.text = item.size
        self.styleColourLabel.text = item.style ?? "Default Text"
        self.quantityStepper.value = Double(cantOfItems)
        self.quantityLabel.text = String(cantOfItems)
        self.lastStep = cantOfItems
    }
}

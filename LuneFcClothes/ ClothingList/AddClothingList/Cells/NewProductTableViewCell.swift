//
//  AddProductTableViewCell.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 12/07/2024.
//

import Foundation
import UIKit

protocol NewProductTableViewCellDelegate: AnyObject {
    func plusControlDidSelect(for item: ClothingItem)
    func minusControlDidSelect(for item: ClothingItem)
}

class NewProductTableViewCell: UITableViewCell {
    
    static let identifier = "AddProductTableViewCell"
    
    private lazy var productImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
    
    private var lastStep: Int = 0
    private var item: ClothingItem = ClothingItem()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var delegate: NewProductTableViewCellDelegate?

    private func setupConstraints() {
        self.contentView.addSubviews(
            self.productImage,
            self.sizeLabel,
            self.sizeNumLabel,
            self.styleLabel,
            self.styleColourLabel,
            self.quantityStepper,
            self.quantityLabel
        )
        
        NSLayoutConstraint.activate([
            
            self.productImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            self.productImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            self.productImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            self.productImage.widthAnchor.constraint(equalToConstant: 150),
            self.productImage.heightAnchor.constraint(equalToConstant: 150),
            
            self.sizeLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            self.sizeLabel.leadingAnchor.constraint(equalTo: self.productImage.trailingAnchor, constant: 16),
//            self.sizeLabel.trailingAnchor.constraint(equalTo: self.sizeNumLabel.leadingAnchor, constant: -16),

            self.sizeNumLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            self.sizeNumLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            self.sizeNumLabel.leadingAnchor.constraint(equalTo: self.sizeLabel.trailingAnchor, constant: 16),
            
            self.styleLabel.topAnchor.constraint(equalTo: self.sizeLabel.bottomAnchor, constant: 15),
            self.styleLabel.leadingAnchor.constraint(equalTo: self.productImage.trailingAnchor, constant: 16),
            self.styleLabel.trailingAnchor.constraint(equalTo: self.styleColourLabel.leadingAnchor, constant: -16),
        
            
            self.styleColourLabel.topAnchor.constraint(equalTo: self.sizeNumLabel.bottomAnchor, constant: 15),
            self.styleColourLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            
            //self.styleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),

            
            self.quantityStepper.topAnchor.constraint(equalTo: self.styleLabel.bottomAnchor, constant: 15),
            self.quantityStepper.leadingAnchor.constraint(equalTo: self.productImage.trailingAnchor,constant: 16),
            self.quantityStepper.trailingAnchor.constraint(equalTo: self.quantityLabel.trailingAnchor,constant: -16),
         
            self.quantityLabel.topAnchor.constraint(equalTo: self.styleColourLabel.bottomAnchor, constant: 15),
//            self.quantityLabel.leadingAnchor.constraint(equalTo: self.quantityStepper.trailingAnchor ),
            self.quantityLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -8)
            
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

//
//  ProductDetail.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 28/02/2024.
//

import Foundation
import UIKit

class ProductDetailViewController: UIViewController {
    
    
    let sizes: [String] = ["XS", "S", "L", "M", "XL"]
    
    private let viewModel: ProductDatailViewModel
    private var buttons: [UIButton] = []
    
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameProductLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textColor = ColorManager.light_neutral_1000_dark_neutral_1000
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.text = "Precio"
        label.textColor = ColorManager.light_neutral_1000_dark_neutral_1000
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textColor = ColorManager.light_neutral_1000_dark_neutral_1000
      
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private  lazy var stockLabel: UILabel = {
        let label = UILabel()
        label.font          = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        label.textColor = ColorManager.light_neutral_1000_dark_neutral_1000
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(
        viewModel: ProductDatailViewModel
    ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.setupUI()
        self.setButtons()
        self.configure(model: self.viewModel.products)
    }
    
    
    
    private func setupUI() {
        
        self.view.addSubviews(
            self.imageView,
            self.nameProductLabel,
            self.priceLabel,
            self.priceValueLabel,
            self.stockLabel
        )
        
        NSLayoutConstraint.activate([
            
            
            
            self.imageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 110),
            self.imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            self.imageView.widthAnchor.constraint(equalToConstant: 200),
            self.imageView.heightAnchor.constraint(equalToConstant: 250),
            
            
            self.nameProductLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor,constant: 60),
            self.nameProductLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 16),
            self.nameProductLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -16),
            
            
            self.priceLabel.topAnchor.constraint(equalTo: self.nameProductLabel.bottomAnchor, constant: 10),
            self.priceLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 16),
            self.priceLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -16),
            
            
            self.priceValueLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 5),
            self.priceValueLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.priceValueLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            // self.priceValueLabel.bottomAnchor.constraint(greaterThanOrEqualTo: self.view.bottomAnchor),
            
            self.stockLabel.topAnchor.constraint(equalTo: priceValueLabel.bottomAnchor, constant: 10),
            self.stockLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 16),
            self.stockLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 16),
            self.stockLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -16),
        ])
    }
    
    
    @objc func editarButtonTapped(_ sender: UIButton) {
        // Acción que se ejecutará cuando se toque el botón
        print("Botón Editar presionado")
    }
    
    private func setButtons() {
        var previousButton: UIButton?
        for size in sizes {
            let button = createSizeButton(withTitle: size)
            self.view.addSubview(button)
            buttons.append(button)
            
            NSLayoutConstraint.activate([
                button.heightAnchor.constraint(equalToConstant: 28),
                button.widthAnchor.constraint(equalToConstant: 28),
                button.topAnchor.constraint(equalTo: stockLabel.bottomAnchor, constant: 20),
                button.leadingAnchor.constraint(equalTo: previousButton?.trailingAnchor ?? view.leadingAnchor, constant: 10)
            ])
            
            previousButton = button
        }
    }
    
    private func createSizeButton(withTitle title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        button.setTitleColor(.gray, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.gray.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    func configure(model: ClothingItem) {
        self.imageView.image = UIImage(named: model.description)
        self.nameProductLabel.text = model.title
        self.priceValueLabel.text = "$\(model.price)"
        self.stockLabel.text = "Cantidad de stock:\(model.stockQuantity)"
    }
}

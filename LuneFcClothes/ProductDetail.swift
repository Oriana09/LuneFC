//
//  ProductDetail.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 28/02/2024.
//

import Foundation
import UIKit

class ProductDetailViewController: UIViewController {
    // MARK: - Properties
     // Assuming Shop is a class
    
    // MARK: - Subviews
     let topPartDetailView = TopPartDetailView()
   let clothingSizeView = ColorSizeView()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .white
        
        // Add subviews
        view.addSubview(topPartDetailView)
        view.addSubview(clothingSizeView)
        
        // Layout constraints
        topPartDetailView.translatesAutoresizingMaskIntoConstraints = false
        clothingSizeView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topPartDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topPartDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topPartDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            clothingSizeView.topAnchor.constraint(equalTo: topPartDetailView.bottomAnchor, constant: 20),
            clothingSizeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            clothingSizeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            // Add more constraints as needed
        ])
    }
}

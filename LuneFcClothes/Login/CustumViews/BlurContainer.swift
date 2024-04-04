//
//  BlurContainer.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 01/04/2024.
//

import UIKit

class BlurContainer: UIView {
    
    let cornerRadius: CGFloat
    private var gradientLayer: CALayer = CALayer()
    private var borderView = UIView()
    
    init(cornerRadius: CGFloat) {
        self.cornerRadius = cornerRadius
        super.init(frame: .zero)
        self.configureView()
        self.setupBlurView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        self.layer.cornerRadius = self.cornerRadius
        self.clipsToBounds = true
        self.layer.borderWidth = 2
        self.layer.borderColor = ColorManager.light_textfield_border_dark_textfield_borde.withAlphaComponent(0.6).cgColor
    }
    
    private func setupBlurView() {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(blurView)
        
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: self.topAnchor),
            blurView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        
        gradientLayer.colors = [
            ColorManager.dark_blue_gradient_light_blue_gradient.cgColor,
            ColorManager.dark_violet_gradient_light_violet_gradient.cgColor
        ]
        
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        
        // Agrega el gradiente a la capa de la vista
        self.gradientLayer.removeFromSuperlayer()
        self.layer.insertSublayer(gradientLayer, at: 0)
        self.gradientLayer = gradientLayer
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.layer.borderColor = ColorManager.light_textfield_border_dark_textfield_borde.withAlphaComponent(0.6).cgColor
    }
}

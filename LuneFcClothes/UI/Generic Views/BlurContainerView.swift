//
//  BlurContainer.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 26/02/2024.
//

import Foundation
import UIKit


class BlurContainerView: UIView {
    
    
    let cornerRadius: CGFloat
    
    init(cornerRadius: CGFloat) {
        self.cornerRadius = cornerRadius
        super.init(frame: .zero)
        
        let blurEffect = UIBlurEffect(style: .systemMaterial)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        self.layer.cornerRadius = self.cornerRadius
        
        // Ajustar el tamaño de la vista de desenfoque para que cubra toda la vista
        blurEffectView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        // Agregar la vista de desenfoque como subvista de esta vista (self)
        addSubview(blurEffectView)
        
        // Asegurarse de que la vista de desenfoque esté detrás de otras vistas
        sendSubviewToBack(blurEffectView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


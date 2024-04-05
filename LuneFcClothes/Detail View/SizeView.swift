//
//  ColorSize.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 28/02/2024.
//

import Foundation
import UIKit

class SizeView: UIView {
    // MARK: - Properties
    let sizes: [String]
    
    // MARK: - Subviews
    private var buttons: [UIButton] = []
    
    // MARK: - Initializers
    
    init(sizes: [String]) {
        self.sizes = sizes
        super.init(frame: .zero)
        
        setupUI()
    }
    
    override init(frame: CGRect) {
        fatalError("You must be use init(sizes)")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("You must be use init(sizes)")
    }
    
    // MARK: - UI Setup
    private func setupUI() {
//        backgroundColor = .white
        
        var previousButton: UIButton?
        
        for size in sizes {
            let button = UIButton(type: .system)
            button.setTitle(size, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            button.setTitleColor(.label, for: .normal)
            button.layer.cornerRadius = 5
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.label.cgColor
            button.translatesAutoresizingMaskIntoConstraints = false
            addSubview(button)
            buttons.append(button)
            
            NSLayoutConstraint.activate([
                button.heightAnchor.constraint(equalToConstant: 28),
                button.widthAnchor.constraint(equalToConstant: 28),
                button.topAnchor.constraint(equalTo: topAnchor, constant: 20),
                button.leadingAnchor.constraint(equalTo: previousButton?.trailingAnchor ?? leadingAnchor, constant: 10)
            ])
            
            previousButton = button
        }
    }
    
    #warning("Crear metodo no privado que tenga como input un string, y recorra todos los botones hasta encontrar el string que le pasamos como input. Una ves encontrado ese boton hacer que su backround cambie de color para que se vea seleccionado. Y los botones que no sean los seleccionados setear su background transparente")
    
    func selectButton(withTitle titleToSelect: String) {
          for button in buttons {
              if let title = button.currentTitle {
                  if title == titleToSelect {
                      button.backgroundColor = ColorManager.button_primary_blue_light_button_prmary_blue_dark// Cambia el color de fondo del botón seleccionado
                  } else {
                      button.backgroundColor = .clear // Establece el color de fondo transparente para los botones no seleccionados
                  }
              }
          }
      }
}

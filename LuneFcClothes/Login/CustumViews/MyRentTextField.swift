//
//  MyRentTextField.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 01/04/2024.
//

import Foundation
import UIKit

class MyRentTextField: UITextField {
    
    private lazy var eyePasswordButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        button.tintColor = ColorManager.light_neutral_500_dark_neutral_600
        button.addTarget(self, action: #selector(eyePasswordVisibility), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let cornerRadius: CGFloat
    private var imageContainer = UIView()
    private var buttonContainer = UIView()
    let image: UIImageView
    let isPaswordTextField: Bool
    
    init(
        cornerRadius: CGFloat,
        image: UIImageView,
        isPaswordTextField: Bool
    ) {
        self.cornerRadius = cornerRadius
        self.image = image
        self.isPaswordTextField = isPaswordTextField
        super.init(frame: .zero)
        
        self.configureView()
        self.configureConstrain()
        if isPaswordTextField {
            self.isSecureTextEntry = true
        }
        self.rightViewMode = isPaswordTextField ? .always : .never
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        self.layer.cornerRadius = self.cornerRadius
        self.backgroundColor = ColorManager.light_neutral_50_dark_neutral_100
        self.layer.borderWidth = 1
        self.layer.borderColor =  ColorManager.light_textfield_border_dark_textfield_borde.cgColor
        self.clipsToBounds = true
        self.image.tintColor = ColorManager.light_neutral_500_dark_neutral_600
        self.image.contentMode = .scaleAspectFit
        self.leftView = self.imageContainer
        self.leftViewMode = .always
        self.rightView = self.buttonContainer
        self.setButtonconstraint()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.layer.borderColor  =  ColorManager.light_textfield_border_dark_textfield_borde.cgColor
    }
    
   
    
    @objc private func eyePasswordVisibility() {
        self.isSecureTextEntry.toggle()
        let imageName = self.isSecureTextEntry ? "eye.slash.fill" : "eye.fill"
        self.eyePasswordButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    func configureConstrain() {
        self.image.translatesAutoresizingMaskIntoConstraints = false
        self.imageContainer.translatesAutoresizingMaskIntoConstraints = false
        
        self.imageContainer.addSubview(image)
  
        NSLayoutConstraint.activate([

            self.imageContainer.widthAnchor.constraint(equalToConstant: 41),
            self.imageContainer.heightAnchor.constraint(equalToConstant: 21),
         
            self.image.centerYAnchor.constraint(equalTo: self.imageContainer.centerYAnchor),
            self.image.centerXAnchor.constraint(equalTo: self.imageContainer.centerXAnchor),
            self.image.widthAnchor.constraint(equalToConstant: 25),
            self.image.heightAnchor.constraint(equalToConstant: 21),
        ])
    }
    
    private func setButtonconstraint() {
        self.eyePasswordButton.translatesAutoresizingMaskIntoConstraints = false
        self.buttonContainer.translatesAutoresizingMaskIntoConstraints = false
     
        self.buttonContainer.addSubview(eyePasswordButton)
        
        NSLayoutConstraint.activate([
            
            self.buttonContainer.widthAnchor.constraint(equalToConstant: 41),
            self.buttonContainer.heightAnchor.constraint(equalToConstant: 21),
     
            self.eyePasswordButton.centerYAnchor.constraint(equalTo: self.buttonContainer.centerYAnchor),
            self.eyePasswordButton.centerXAnchor.constraint(equalTo: self.buttonContainer.centerXAnchor),
            self.eyePasswordButton.widthAnchor.constraint(equalToConstant: 25),
            self.eyePasswordButton.heightAnchor.constraint(equalToConstant: 21)
        ])
    }
}


//class MyRentTextField: UITextField {
//    
//    private lazy var eyePasswordButton: UIButton = {
//        let button = UIButton()
//        button.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
//        button.tintColor = ColorManager.light_neutral_500_dark_neutral_600
//        button.addTarget(self, action: #selector(eyePasswordVisibility), for: .touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//    
//    private var imageContainer = UIView()
//    private var buttonContainer = UIView()
//    let image: UIImageView
//    let cornerRadius: CGFloat
//    let isPaswordTextField: Bool
//    
//    init(
//        cornerRadius: CGFloat,
//        image: UIImageView,
//        isPaswordTextField: Bool
//    ) {
//        self.cornerRadius = cornerRadius
//        self.image = image
//        self.isPaswordTextField = isPaswordTextField
//        super.init(frame: .zero)
//        
//        self.configureView()
//        self.configureConstrain()
//        self.setButtonconstraint()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func configureView() {
//        self.layer.cornerRadius = self.cornerRadius
//        self.backgroundColor = ColorManager.light_neutral_50_dark_neutral_100
//        self.layer.borderWidth = 1
//        self.layer.borderColor =  ColorManager.light_textfield_border_dark_textfield_borde.cgColor
//        self.clipsToBounds = true
//        
//        self.image.tintColor = ColorManager.button_primary_blue_light_button_prmary_blue_dark
//        self.image.contentMode = .scaleAspectFit
//        
//        self.leftView = self.imageContainer
//        self.leftViewMode = .always
//        
//        self.rightView = self.buttonContainer
//        self.setButtonconstraint()
//    }
//    
//    private func setupPasswordVisibility() {
//        if isPaswordTextField {
//            self.isSecureTextEntry = true
//        }
//        self.rightViewMode = isPaswordTextField ? .always : .never
//    }
//    
//    @objc private func eyePasswordVisibility() {
//        self.isSecureTextEntry.toggle()
//        let imageName = self.isSecureTextEntry ? "eye.slash.fill" : "eye.fill"
//        self.eyePasswordButton.setImage(UIImage(systemName: imageName), for: .normal)
//    }
//    
//    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
//        self.layer.borderColor  =  ColorManager.light_textfield_border_dark_textfield_borde.cgColor
//    }
//    
//
//    func configureConstrain() {
//        self.image.translatesAutoresizingMaskIntoConstraints = false
//        self.imageContainer.translatesAutoresizingMaskIntoConstraints = false
//        
//        self.imageContainer.addSubview(self.image)
//        
//        NSLayoutConstraint.activate([
//            
//            self.imageContainer.widthAnchor.constraint(
//                equalToConstant: 41
//            ),
//            self.imageContainer.heightAnchor.constraint(
//                equalToConstant: 21
//            ),
//            self.image.centerYAnchor.constraint(
//                equalTo: self.imageContainer.centerYAnchor
//            ),
//            self.image.centerXAnchor.constraint(
//                equalTo: self.imageContainer.centerXAnchor
//            ),
//            self.image.widthAnchor.constraint(
//                equalToConstant: 25
//            ),
//            self.image.heightAnchor.constraint(
//                equalToConstant: 21
//            ),
//        ])
//    }
//   
//    private func setButtonconstraint() {
////        self.eyePasswordButton.translatesAutoresizingMaskIntoConstraints = false
//        self.buttonContainer.translatesAutoresizingMaskIntoConstraints = false
//        
//        self.buttonContainer.addSubview(self.eyePasswordButton)
//        
//        NSLayoutConstraint.activate([
//            
//            self.buttonContainer.widthAnchor.constraint(
//                equalToConstant: 41
//            ),
//            self.buttonContainer.heightAnchor.constraint(
//                equalToConstant: 21
//            ),
//            
//            self.eyePasswordButton.centerYAnchor.constraint(
//                equalTo: self.buttonContainer.centerYAnchor
//            ),
//            self.eyePasswordButton.centerXAnchor.constraint(
//                equalTo: self.buttonContainer.centerXAnchor
//            ),
//            self.eyePasswordButton.widthAnchor.constraint(
//                equalToConstant: 25
//            ),
//            self.eyePasswordButton.heightAnchor.constraint(
//                equalToConstant: 21
//            )
//        ])
//    }
//}

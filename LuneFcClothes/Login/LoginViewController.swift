//
//  LoginViewController.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 01/04/2024.
//


import UIKit
import FirebaseAuth


class LoginViewController: UIViewController {
   
    private let houseImages: [UIImage] = [
        UIImage(named: "Image")!,
        UIImage(named: "imagen1")!,
        UIImage(named: "Remera")!
    ]
    
    private let myRentLabels: [UIColor] = [
        ColorManager.light_blue_house_dark_blue_house,
        ColorManager.light_snow_house_dark_snow_house,
        ColorManager.light_hotel_house_dark_hotel_house
    ]
    private var blurBoxOriginYPosition: Double = 0
    private var currentIndex = 0
    
    private lazy var viewContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        return container
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView(
            arrangedSubviews: [
                self.loginLabel,
                self.mailTextField,
                self.passwordTextField,
                self.continueButton
            ])
        stack.axis      = .vertical
        stack.spacing   = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text          = "Bienvenido a"
        label.font          = .systemFont(ofSize: 34, weight: .bold)
        label.contentMode   = .left
        label.textColor     = ColorManager.light_neutral_1000_dark_neutral_1000
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var myRentLabel: UILabel = {
        let label = UILabel()
        label.text         = "Mi Renta"
        label.font         = .systemFont(ofSize: 34, weight: .bold)
        label.contentMode  = .left
        label.textColor    = ColorManager.light_blue_house_dark_blue_house
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var houseImage: UIImageView = {
        let image = UIImageView()
        image.contentMode    = .scaleAspectFit
        image.image          = UIImage(named: "imagen1")
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private lazy var blurBox: BlurContainer = {
        let container = BlurContainer(cornerRadius: 15.0)
        container.translatesAutoresizingMaskIntoConstraints = false
        
        return container
    }()
    
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.text          = "Iniciar Sesion"
        label.font          = .systemFont(ofSize: 28, weight: .bold)
        label.textColor     = ColorManager.light_neutral_1000_dark_neutral_1000
        label.textAlignment = .center
        
        return label
    }()
    
    private var keyboardHeight: CGFloat = 0
    
    private lazy var mailTextField: MyRentTextField = {
        let mailTextField = MyRentTextField(
            cornerRadius: 8,
            image: UIImageView(
                image: UIImage(systemName: "envelope.fill")
            ),
            isPaswordTextField: false
        )
        mailTextField.placeholder   = "Mail"
        mailTextField.delegate      = self
        mailTextField.autocapitalizationType = .none
        mailTextField.translatesAutoresizingMaskIntoConstraints = false
        
        return mailTextField
    }()
    
    private lazy var passwordTextField: MyRentTextField = {
        let passwordTextField = MyRentTextField(
            cornerRadius: 8,
            image: UIImageView(
                image: UIImage(systemName: "lock.fill")
            ),
            isPaswordTextField: true
        )
        passwordTextField.placeholder   = "Contraseña"
        passwordTextField.delegate      = self
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        return passwordTextField
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton()
        button.backgroundColor    = ColorManager.button_primary_blue_light_button_prmary_blue_dark
        button.isEnabled          = false
        button.alpha              =  0.5
        button.setTitle("Continuar", for: .normal)
        button.tintColor          = ColorManager.light_neutral_0_dark_neutral_1000
        button.titleLabel?.font   = .systemFont(ofSize: 20, weight: .bold)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(continueAction), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.color = ColorManager.sharedInstance.dark_neutral_1000
        view.startAnimating()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
 
    var viewModel: LoginViewModel?
    
    init(
        viewModel: LoginViewModel = LoginViewModel()
    ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorManager.light_neutral_50_dark_neutral_100
        self.setConstrains()
        self.updateButtonState(isEnable: false)
        self.activityIndicatorView.isHidden = true
        self.animationLabel()
        self.viewModel?.delegate = self
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
   
        if #available(iOS 15.0, *) {
            // Utiliza UISheetPresentationController para iOS 15 y posteriores
            let presentationController = presentationController as? UISheetPresentationController
            presentationController?.detents = [.medium(), .large()]
            presentationController?.selectedDetentIdentifier = .large
            presentationController?.prefersGrabberVisible = true
            presentationController?.preferredCornerRadius = 20
           // dismiss(animated: true, completion: nil)
        } else {
            // Utiliza UIPopoverPresentationController para versiones anteriores
            let popoverController = popoverPresentationController
            // Configura las propiedades de presentación para la versión anterior de iOS
        }
    }
    

    private func updateButtonState(isEnable: Bool) {
        self.continueButton.isEnabled = isEnable
        self.continueButton.alpha     = isEnable ? 1.0 : 0.5
    }
    
    @objc func continueAction() {
        self.view.endEditing(true)
        self.updateButtonState(isEnable: false)
        self.activityIndicatorView.isHidden = false
         
        //Este bloque se va a ejecutar si el mail y password son correctas
        guard let email = self.mailTextField.text, let password = self.passwordTextField.text else {
            return
        }
        
        self.viewModel!.login(mail: email, pasaword: password)
        
    }
    
    private var blurBoxHasPosition: Bool = false
    
    //se calcula si el campo de texto está oculto por el teclado.
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if !blurBoxHasPosition {
            self.blurBoxOriginYPosition = self.blurBox.frame.origin.y
            self.blurBoxHasPosition = true
        }
        
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            
            // Calcula la posición del campo de texto con respecto al teclado
            let fieldFrame = blurBox.frame
            let fieldOriginY = fieldFrame.origin.y
            let fieldHeight = fieldFrame.size.height
            let visibleRectHeight = viewContainer.frame.size.height - keyboardHeight
            
            // Comprueba si el campo de texto está oculto por el teclado
            if fieldOriginY + fieldHeight > visibleRectHeight {
                let offsetY = fieldOriginY + fieldHeight - visibleRectHeight
                
                // Ajusta la posición de la vista o el campo de texto hacia arriba
                self.blurBox.frame.origin.y -= offsetY + 16
                // o
                // tuTextField.frame.origin.y -= offsetY
            }
        }
    }
    //  se restaura la posición original de la vista
    @objc func keyboardWillHide() {
        self.hideKeyboard()
    }
    
    private func setConstrains() {
        self.view.addSubview(viewContainer)
        self.viewContainer.addSubviews(
            self.welcomeLabel,
            self.myRentLabel,
            self.houseImage,
            self.blurBox
        )
        self.blurBox.addSubviews(
            self.stack
        )
        self.continueButton.addSubview(self.activityIndicatorView)
        
        
        let leadingConstraint = self.viewContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16)
        leadingConstraint.priority = .init(999)
        
        let trailingConstraint = self.viewContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
        trailingConstraint.priority = .init(999)
        
        NSLayoutConstraint.activate([
            self.viewContainer.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 16),
            self.viewContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.viewContainer.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.viewContainer.widthAnchor.constraint(lessThanOrEqualToConstant: 500),
            leadingConstraint,
            trailingConstraint,
            
            self.welcomeLabel.topAnchor.constraint(equalTo: self.viewContainer.topAnchor),
            self.welcomeLabel.leadingAnchor.constraint(equalTo: self.viewContainer.leadingAnchor),
            
            self.myRentLabel.topAnchor.constraint(equalTo: self.welcomeLabel.bottomAnchor),
            self.myRentLabel.leadingAnchor.constraint(equalTo: self.viewContainer.leadingAnchor),
            
            self.houseImage.topAnchor.constraint(equalTo: self.myRentLabel.bottomAnchor),
            self.houseImage.widthAnchor.constraint(equalTo: self.viewContainer.widthAnchor),
            self.houseImage.heightAnchor.constraint(equalToConstant: 250),
//            self.houseImage.centerXAnchor.constraint(equalTo: self.viewContainer.centerXAnchor),
            
            self.blurBox.topAnchor.constraint(
                equalTo: self.houseImage.bottomAnchor,
                constant: -93),
            self.blurBox.leadingAnchor.constraint(equalTo: self.viewContainer.leadingAnchor),
            self.blurBox.trailingAnchor.constraint(equalTo: self.viewContainer.trailingAnchor),
            
            self.mailTextField.heightAnchor.constraint(equalToConstant: 44),
            
            self.passwordTextField.heightAnchor.constraint(equalToConstant: 44),
            
            self.continueButton.heightAnchor.constraint(equalToConstant: 44),
            
            self.stack.topAnchor.constraint(
                equalTo: self.blurBox.topAnchor,
                constant: 16
            ),
            self.stack.bottomAnchor.constraint(
                equalTo: self.blurBox.bottomAnchor,
                constant: -16
            ),
            self.stack.leadingAnchor.constraint(
                equalTo: self.blurBox.leadingAnchor,
                constant: 16
            ),
            self.stack.trailingAnchor.constraint(
                equalTo: self.blurBox.trailingAnchor,
                constant: -16
            ),
            
            self.activityIndicatorView.centerYAnchor.constraint(equalTo: self.continueButton.centerYAnchor),
            self.activityIndicatorView.widthAnchor.constraint(equalToConstant: 22),
            self.activityIndicatorView.heightAnchor.constraint(equalToConstant: 22),
            self.activityIndicatorView.trailingAnchor.constraint(equalTo: self.continueButton.trailingAnchor, constant: -16),
            
        ])
    }
    
    private func animationLabel() {
        self.welcomeLabel.alpha  = 0
        self.myRentLabel.alpha   = 0
        self.houseImage.alpha    = 0
        self.blurBox.alpha       = 0
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0.0,
            options: .curveEaseOut
        ) {
            self.welcomeLabel.frame.origin.y += -50
            self.welcomeLabel.alpha = 1
        }
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0.6,
            options: .curveEaseOut
        ) {
            self.myRentLabel.frame.origin.y += -50
            self.myRentLabel.alpha = 1
            self.houseImage.frame.origin.y += -50
            self.houseImage.alpha = 1
        }
        
        
        UIView.animate(
            withDuration: 0.5,
            delay: 1.2,
            options: .curveEaseOut
        ) {
            self.blurBox.frame.origin.y += -50
            self.blurBox.alpha = 1
            
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.animateImages()
        }
    }
    
    private func animateImages() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
            self.houseImage.alpha = 0.0
            self.myRentLabel.alpha = 0.0
        }) { _ in
            self.currentIndex = (self.currentIndex + 1) % self.houseImages.count
            self.houseImage.image = self.houseImages[self.currentIndex]
            self.myRentLabel.textColor = self.myRentLabels[self.currentIndex]
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
                self.houseImage.alpha = 1.0
                self.myRentLabel.alpha = 1.0
            }) { _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    self.animateImages()
                }
            }
        }
    }
    
     
}

extension LoginViewController: LoginViewModelDelegate {
    
    func onLoginSuccess() {
        self.updateButtonState(isEnable: true)
        self.activityIndicatorView.isHidden = true

        let viewModel = CategoryViewModel()
        let categoryVC = CategoryViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(categoryVC, animated: true)
    }
    
    func onLoginError(_ error: LoginViewModel.Error) {
        
        self.updateButtonState(isEnable: true)
        self.activityIndicatorView.isHidden = true
        
        let alertController = UIAlertController(
            title: "Error al iniciar sesión",
            message: error.description,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(
            title: "OK",
            style: .default,
            handler: nil
        )
        
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        let mailIsEmpty = self.mailTextField.text!.isEmpty
        let passwordIsEmpty = self.passwordTextField.text!.isEmpty
        
        let textFieldsHasText = !mailIsEmpty && !passwordIsEmpty
        
        self.updateButtonState(isEnable: textFieldsHasText)
        
        self.view.endEditing(true)
    }
    
    
    func hideKeyboard() {
        // Oculta el teclado
        UIView.animate(withDuration: 0.3) {
            self.blurBox.frame.origin.y = self.blurBoxOriginYPosition
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Oculta el teclado
        self.view.endEditing(true)
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        let mailIsEmpty = self.mailTextField.text?.isEmpty ?? false
        let passwordIsEmpty = self.passwordTextField.text?.isEmpty ?? false
        
        // Actualizamos el estado del botón de continuar
        self.updateButtonState(isEnable: !mailIsEmpty && !passwordIsEmpty)
        
    }
    
}

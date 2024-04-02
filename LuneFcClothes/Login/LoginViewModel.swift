//
//  LoginViewModel.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 01/04/2024.
//

import Foundation

protocol LoginViewModelDelegate: AnyObject {
    func onLoginSuccess()
    func onLoginError(_ error: LoginViewModel.Error)
}

class LoginViewModel {
    
        enum Error: Int {
        case invalidFormated    = 17008
        case invalidPassword    = 17009
        case unregisteredUser   = 17011
        case connectionError    = 17020
     
        case unowned
        
        var description: String {
            switch self {
            case .invalidFormated:
                return "Formato de mail incorrecto"
            case .unowned:
                return "Parece que ha ocurrido un error. Pruebe devuelta en unos minutos"
            case .invalidPassword:
                return "Contraseña incorrecta"
            case .unregisteredUser:
                return "Usuario no registrado"
            case .connectionError:
                return "Se ha producido un error de red"
            }
        }
    }
    
    private let loginRepository: LoginRepository
    weak var delegate: LoginViewModelDelegate?
    
    init(
        delegate: LoginViewModelDelegate? = nil,
        loginRepository: LoginRepository = LoginRepository()
    ) {
        self.delegate = delegate
        self.loginRepository = loginRepository
    }
    
    func login(mail: String, pasaword: String) {
        
        self.loginRepository.login(email: mail, password: pasaword) { result in
            switch result {
            case .success(let user):
                self.delegate?.onLoginSuccess()
            case .failure(let error):
                self.delegate?.onLoginError(
                    LoginViewModel.Error(rawValue: error.code) ?? .unowned
                )
            }
        }
    }
}

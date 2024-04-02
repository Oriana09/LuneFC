//
//  LoginRepository.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 01/04/2024.
//

import Foundation
import FirebaseAuth

class LoginRepository {
    
    func login(email: String, password: String, completion: @escaping (Result<UserLoginModel,NSError>) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            
            if let error = error as? NSError {
                completion(.failure(error))
            }
            
            if let result = result {
                let UserLoginModel = UserLoginModel(
                    email: result.user.email,
                    name: result.user.displayName
                )
                completion(.success(UserLoginModel))
            }
        }
    }
}

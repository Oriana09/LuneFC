//
//  User.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 05/04/2024.
//

import Foundation
import RealmSwift

class User: Object {
    
    @objc dynamic var email: String = ""
    @objc dynamic var isLoggued: Bool = false
    
    required override init() {
        super.init()
    }

    init(email: String, isLoggued: Bool) {
        self.email = email
        self.isLoggued = isLoggued
        super.init()
    }

    
    static func isLoggued() -> Bool {
        let realm = try! Realm()
        return realm.objects(User.self).first?.isLoggued ?? false
    }
    
    
    // Función de autenticación
//    static func authenticate(name: String, email: String) -> Bool {
//        let realm = try! Realm()
//        // Buscar el usuario en la base de datos
//        if let user = realm.objects(User.self).filter("email == %@", email).first {
//            // Verificar la contraseña
//            if user.name == name {
//                // La contraseña coincide
//                return true
//            }
//        }
//        // Usuario no encontrado o contraseña incorrecta
//        return false
//    }
}

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
}

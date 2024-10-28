//
//  AppDelegate.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 08/02/2024.
//

import UIKit
import RealmSwift
import FirebaseCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.configureRealm()
        self.setDefaultsCategories()
        FirebaseApp.configure()
        
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
    
    private func configureRealm() {
        let config = Realm.Configuration(
            schemaVersion: 27, // Asegúrate de cambiar esta versión si ya lo has hecho antes
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 2 {
                    // Diccionario para verificar duplicados basado en el id
                    var uniqueItems = [String: Bool]()
                    
                    // Recorre todos los objetos de tipo `ClothingItem` en la migración
                    migration.enumerateObjects(ofType: ClothingItem.className()) { oldObject, newObject in
                        if let id = oldObject?["id"] as? String {
                            // Si el id ya está en el diccionario, elimina el objeto actual
                            if uniqueItems[id] != nil {
                                migration.delete(newObject!)
                            } else {
                                // Marca el id como único
                                uniqueItems[id] = true
                            }
                        }
                    }
                }
                //            migrationBlock: { migration, oldSchemaVersion in
                //                if oldSchemaVersion < 2 {
                //                    // Aquí puedes manejar cualquier migración específica
                //                    migration.enumerateObjects(ofType: ClothingItem.className()) { oldObject, newObject in
                //                        newObject!["id"] = ObjectId.generate()
                //                    }
                //                }
            }
        )
        
        
        Realm.Configuration.defaultConfiguration = config
    }
    
    private func setDefaultsCategories() {
        
        guard UserDefaults.standard.bool(forKey: "isFirstAppRun") == false else {
            return
        }
        
        let defaultsCategories: [Category] = [
            Category(
                imageData: UIImage(named: "AllCategory")?.jpegData(compressionQuality: 1),
                name: "Todas las categorías",
                sizes: [""]
            ),
            Category(
                imageData: UIImage(named: "Pantalon")?.jpegData(compressionQuality: 1),
                name: "Pantalones",
                sizes: ["38", "40", "42", "44", "46", "48"]
            ),
            Category(
                imageData: UIImage(named: "Remera")?.jpegData(compressionQuality: 1),
                name: "Remeras",
                sizes: ["XS", "S", "M", "L", "XL"]
            ),
            Category(
                imageData: UIImage(named: "Short")?.jpegData(compressionQuality: 1),
                name: "Shorts",
                sizes: ["38", "40", "42", "44", "46", "48"]
            ),
            Category(
                imageData: UIImage(named: "Buzos")?.jpegData(compressionQuality: 1),
                name: "Buzos",
                sizes: ["XS", "S", "M", "L", "XL"]
            )
        ]
        
        do {
            let realm = try! Realm()
            try realm.write {
                realm.add(defaultsCategories)
            }
            UserDefaults.standard.set(true, forKey: "isFirstAppRun")
        } catch {
            print("Error saving default category: \(error.localizedDescription)")
        }
    }
}



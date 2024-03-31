//
//  AppDelegate.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 08/02/2024.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.configureRealm()
        self.setDefaultsCategories()
    
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
    
    private func configureRealm() {
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in }
        )
        
        Realm.Configuration.defaultConfiguration = config
    }
    
    private func setDefaultsCategories() {
        
        guard UserDefaults.standard.bool(forKey: "isFirstAppRun") == false else {
            return
        }
        
        let defaultsCategories: [Category] = [
            Category(
                imageData: UIImage(named: "Pantalon")?.jpegData(compressionQuality: 1),
                name: "Pantalones"
            ),
            Category(
                imageData: UIImage(named: "Remera")?.jpegData(compressionQuality: 1),
                name: "Remeras"
            ),
            Category(
                imageData: UIImage(named: "Short")?.jpegData(compressionQuality: 1),
                name: "shorts"
            ),
            Category(
                imageData: UIImage(named: "Buzos")?.jpegData(compressionQuality: 1),
                name: "Buzos"
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


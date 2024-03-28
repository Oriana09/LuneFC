//
//  SceneDelegate.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 08/02/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.setNavigationBarAppearance()
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let clothingVC = CategoryViewController()
        let navigationController = UINavigationController(rootViewController: clothingVC) // Aquí se incrusta en el UINavigationController
        window?.rootViewController = navigationController
        
        window?.makeKeyAndVisible()
        
    }

    func setNavigationBarAppearance() {
        if #available(iOS 15, *) {
            let navBarAppearance: UINavigationBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.shadowColor = .blue

            UINavigationBar.appearance().tintColor = .systemGreen
            UINavigationBar.appearance().standardAppearance = navBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
           
        } else {
            UINavigationBar.appearance().tintColor = .systemGreen
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) { }
    
    func sceneDidBecomeActive(_ scene: UIScene) { }
    
    func sceneWillResignActive(_ scene: UIScene) { }
    
    func sceneWillEnterForeground(_ scene: UIScene) { }
    
    func sceneDidEnterBackground(_ scene: UIScene) { }
}


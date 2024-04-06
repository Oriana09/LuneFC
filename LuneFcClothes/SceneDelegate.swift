//
//  SceneDelegate.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 08/02/2024.
//

import UIKit
import RealmSwift
import FirebaseCore

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.setNavigationBarAppearance()
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let navigationController = UINavigationController(
            rootViewController: self.createRootVC()
        )
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func setNavigationBarAppearance() {
        if #available(iOS 15, *) {
            
            let navBarAppearance: UINavigationBarAppearance = UINavigationBarAppearance()
            
            
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
    
    private func createRootVC() -> UIViewController {
        if User.isLoggued() {
            let categoryVM = CategoryViewModel()
            let categoryVC = CategoryViewController(
                viewModel: categoryVM
            )
            
            return categoryVC
        } else {
            let loginViewController = LoginViewController()
            
            return loginViewController
        }
    }
}


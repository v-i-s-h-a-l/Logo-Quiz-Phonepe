//
//  SceneDelegate.swift
//  Logo-Quiz
//
//  Created by Vishal Singh on 10/04/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        
        guard let window = window else { return }
        window.windowScene = windowScene
        let appCoordinator = AppCoordinator(with: window)
        appCoordinator.start()
    }
}


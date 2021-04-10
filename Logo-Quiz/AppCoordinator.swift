//
//  AppCoordinator.swift
//  Logo-Quiz
//
//  Created by Vishal Singh on 10/04/21.
//

import UIKit

class AppCoordinator {
    
    private weak var window: UIWindow!
    
    private var navigationController: UINavigationController!

    init(with window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let playGameViewModel = PlayGameViewModel(with: LogoLoader())
        navigationController = UINavigationController(rootViewController: PlayGameViewController(with: playGameViewModel))
        navigationController.navigationBar.isHidden = true
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

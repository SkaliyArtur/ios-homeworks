//
//  Factory.swift
//  Navigation
//
//  Created by Artur Skaliy on 16.09.2022.
//

import Foundation
import UIKit

class Factory {
    enum Views {
        case profile
        case feeds
        case favorites
    }
    
    let navigationController: UINavigationController
    let viewController: Views
    
    init(navigationController: UINavigationController, viewController: Views) {
        self.navigationController = navigationController
        self.viewController = viewController
        startModule()
    }
    func startModule() {
        
        switch viewController {
        case .profile:
            
//            let profileCoordinator = ProfileCoordinator(navigationController: navigationController)
//            let controller = LogInViewController(coordinator: profileCoordinator)
//            controller.loginDelegate = MyLoginFactory().makeLoginInspector()
//            controller.checkerService = CheckerService()
//            controller.localAuthService = LocalAuthorizationService()
            let controller = ProfileViewController()
            navigationController.tabBarItem = .init(title: NSLocalizedString("Profile", comment: ""), image: UIImage(named: AppConstants.Asssets.profile), tag: 0)
            navigationController.setViewControllers([controller], animated: true)
            
        case .feeds:
            let controller = FeedViewController()
            navigationController.tabBarItem = .init(title: NSLocalizedString("Feeds", comment: ""), image: UIImage(named: AppConstants.Asssets.feeds), tag: 1)
            navigationController.setViewControllers([controller], animated: true)

        case .favorites:
            let controller = PostViewController()
            navigationController.tabBarItem = .init(title: NSLocalizedString("Favorties", comment: ""), image: UIImage(named: AppConstants.Asssets.favorites), tag: 2)
            navigationController.setViewControllers([controller], animated: true)
        }
    }
}

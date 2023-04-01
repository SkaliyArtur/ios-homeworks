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
        case feed
        case postFeed
//        case map
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
            
            let profileCoordinator = ProfileCoordinator(navigationController: navigationController)
            let controller = LogInViewController(coordinator: profileCoordinator)
//            controller.loginDelegate = MyLoginFactory().makeLoginInspector()
            controller.checkerService = CheckerService()
            controller.localAuthService = LocalAuthorizationService()
            navigationController.tabBarItem = .init(title: NSLocalizedString("Profile", comment: ""), image: UIImage(systemName: "person"), tag: 0)
            navigationController.setViewControllers([controller], animated: true)
            
        case .feed:
            let controller = FeedViewController()
            navigationController.tabBarItem = .init(title: NSLocalizedString("Feed", comment: ""), image: UIImage(systemName: "list.bullet"), tag: 1)
            navigationController.setViewControllers([controller], animated: true)

        case .postFeed:
            let controller = PostViewController()
            navigationController.tabBarItem = .init(title: NSLocalizedString("Posts", comment: ""), image: UIImage(systemName: "star"), tag: 2)
//            navigationController.setViewControllers([controller], animated: true)
//
//        case .map:
//            let controller = MapViewController()
//            navigationController.tabBarItem = .init(title: NSLocalizedString("Map", comment: ""), image: UIImage(systemName: "map"), tag: 3)
//            navigationController.setViewControllers([controller], animated: true)
            
        }
    }
}

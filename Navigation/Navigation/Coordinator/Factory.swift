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
            controller.loginDelegate = MyLoginFactory().makeLoginInspector()
            navigationController.tabBarItem = .init(title: "Profile", image: UIImage(systemName: "person"), tag: 0)
            navigationController.setViewControllers([controller], animated: true)
            
        case .feed:
            let controller = FeedViewController()
            navigationController.tabBarItem = .init(title: "Feed", image: UIImage(systemName: "list.bullet"), tag: 1)
            navigationController.setViewControllers([controller], animated: true)
            
        case .postFeed:
            let controller = PostViewController()
            navigationController.tabBarItem = .init(title: "Posts", image: UIImage(systemName: "star"), tag: 2)
            navigationController.setViewControllers([controller], animated: true)
        }
    }
}

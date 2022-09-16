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
            
            let controller = LogInViewController()
            navigationController.tabBarItem = .init(title: "Profile", image: UIImage(systemName: "person"), tag: 0)
            navigationController.setViewControllers([controller], animated: true)
            
        case .feed:
            let feedCoordinator = FeedCoordinator()
            let controller = FeedViewController(coordinator: feedCoordinator)
            navigationController.tabBarItem = .init(title: "Feed", image: UIImage(named: "list.bullet.circle"), tag: 1)
            navigationController.setViewControllers([controller], animated: true)
        }
    }
}

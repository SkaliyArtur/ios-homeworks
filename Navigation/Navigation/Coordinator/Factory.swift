//
//  Factory.swift
//  Navigation
//
//  Created by Artur Skaliy on 16.09.2022.
//

import Foundation
import UIKit
import RealmSwift

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
            
            let profileCoordinator = ProfileCoordinator(navigationController: navigationController)
            let controller = LogInViewController(coordinator: profileCoordinator)
            controller.loginDelegate = MyLoginFactory().makeLoginInspector()
            navigationController.tabBarItem = .init(title: "Profile", image: UIImage(systemName: "person"), tag: 0)
            do {
                let realm = try Realm(configuration: Realm.Configuration(encryptionKey: EncryptionClass().getKey()))
                let authData = Array(realm.objects(RealmLoginModel.self).filter("isAuthorized = true"))
                if authData.count >= 1 {
                    profileCoordinator.startView()
                } else {
                    navigationController.setViewControllers([controller], animated: true)
                }
            } catch {
                print("Factory REALM error: \(error.localizedDescription)")
            }
            
        case .feed:
            let feedCoordinator = FeedCoordinator()
            let controller = FeedViewController(coordinator: feedCoordinator)
            navigationController.tabBarItem = .init(title: "Feed", image: UIImage(named: "list.bullet.circle"), tag: 1)
            navigationController.setViewControllers([controller], animated: true)
        }
    }
}

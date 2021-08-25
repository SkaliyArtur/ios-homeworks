//
//  AppDelegate.swift
//  Navigation
//
//  Created by Artur Skaliy on 18.08.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let tabBar = UITabBarController()
        var profileNC = UINavigationController()
        var feedNC = UINavigationController()
        let profileVC = ProfileViewController()
        let feedVC = FeedViewController()
        
        
        profileVC.title = "Profile"
        feedVC.view.backgroundColor = .blue
        profileNC = UINavigationController(rootViewController: profileVC)
        feedNC = UINavigationController(rootViewController: feedVC)
        profileNC.tabBarItem = .init(title: "Profile", image: UIImage(systemName: "person"), tag: 0)
        feedNC.tabBarItem = .init(title: "Лента", image: UIImage(named: "list.bullet.circle"), tag: 1)
        
        
        tabBar.viewControllers = [profileNC, feedNC]
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBar
        window?.makeKeyAndVisible()
        
        return true
        
    }


}


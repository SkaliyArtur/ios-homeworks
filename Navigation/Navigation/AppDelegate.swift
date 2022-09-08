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
        
        
//        let profileVC = ProfileViewController()
        let feedVC = FeedViewController()
        
        let loginVC = LogInViewController()
        
        let photosVC = PhotosViewController()
        
        
//        profileVC.title = "Profile"
        feedVC.title = "Feed"
        feedVC.view.backgroundColor = .blue
        
        photosVC.title = "Photo Gallery"
        
        profileNC = UINavigationController(rootViewController: loginVC)
        feedNC = UINavigationController(rootViewController: feedVC)
        
        
        profileNC.tabBarItem = .init(title: "Profile", image: UIImage(systemName: "person"), tag: 0)
        feedNC.tabBarItem = .init(title: "Feed", image: UIImage(named: "list.bullet.circle"), tag: 1)
        
        
        
        tabBar.viewControllers = [profileNC, feedNC]
//        profileNC.isNavigationBarHidden = true
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBar
        window?.makeKeyAndVisible()
        
        return true
        
    }


}


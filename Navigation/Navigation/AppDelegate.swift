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
//        let tabBar = UITabBarController()
//
//        var profileNC = UINavigationController()
//        var feedNC = UINavigationController()
        
        
//        let profileVC = ProfileViewController()
//        let feedVC = FeedViewController()
        let loginVC = LogInViewController()
//        //Задание 4.1: сделал зависимость контрллера и инспектора
//        loginVC.loginDelegate = LoginInspector()
//        //Задание 4.2: Фабрика
        loginVC.loginDelegate = MyLoginFactory().makeLoginInspector()
//
//        let photosVC = PhotosViewController()
        
        
//        profileVC.title = "Profile"
//        feedVC.title = "Feed"
//        feedVC.view.backgroundColor = .blue
        
//        photosVC.title = "Photo Gallery"
        
//        profileNC = UINavigationController(rootViewController: loginVC)
//        feedNC = UINavigationController(rootViewController: feedVC)
        
        
//        profileNC.tabBarItem = .init(title: "Profile", image: UIImage(systemName: "person"), tag: 0)
//        feedNC.tabBarItem = .init(title: "Feed", image: UIImage(named: "list.bullet.circle"), tag: 1)
        
        
        
//        tabBar.viewControllers = [profileNC, feedNC]
//        profileNC.isNavigationBarHidden = true
        
        let mainCoordinator: MainCoordinator = MainCoordinatorImp()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = mainCoordinator.startApplication()
        window?.makeKeyAndVisible()
        
        return true
        
    }


}


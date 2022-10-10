//
//  AppDelegate.swift
//  Navigation
//
//  Created by Artur Skaliy on 18.08.2021.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let mainCoordinator: MainCoordinator = MainCoordinatorImp()
        
        // Отклчил, чтобы не пачкало терминал 
//        let appConfiguration = AppConfiguration.allCases.randomElement()!
//        NetworkService.request(for: appConfiguration)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = mainCoordinator.startApplication()
        window?.makeKeyAndVisible()
        
        
        FirebaseApp.configure()
        return true
        
    }

    


}


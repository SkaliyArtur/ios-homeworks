//
//  AppDelegate.swift
//  Navigation
//
//  Created by Artur Skaliy on 18.08.2021.
//

import UIKit
import FirebaseCore
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //Задаём главный экран при запуске
        let mainCoordinator: MainCoordinator = MainCoordinatorImp()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = mainCoordinator.startApplication()
        window?.makeKeyAndVisible()

        //Кофигурируем FireBase
        FirebaseApp.configure()
        return true
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        //Если приложение закрывается - считаем что пользователь разлогинен
        do {
            try Auth.auth().signOut()
        } catch {
            print("Неизвестная ошибка")
        }
    }

    


}


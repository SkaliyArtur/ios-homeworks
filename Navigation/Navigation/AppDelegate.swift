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
        
        
        func getDocumentsDirectory() -> URL {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let documentsDirectory = paths[0]
            return documentsDirectory
        }
        print(getDocumentsDirectory())
        
        let mainCoordinator: MainCoordinator = MainCoordinatorImp()
        
        // Отключил, чтобы не пачкало терминал 
//        let appConfiguration = AppConfiguration.allCases.randomElement()!
//        NetworkService.request(for: appConfiguration)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = mainCoordinator.startApplication()
        window?.makeKeyAndVisible()
        
        
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


//
//  AppDelegate.swift
//  Documents
//
//  Created by Artur Skaliy on 15.10.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Функция получения URL корневой папки Documents
        func getDocumentsURL() -> URL {
            let documentsURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let doucmentsURL = documentsURLs[0]
            return doucmentsURL
        }
        // при запуске приложения по умолчанию открываем папку Documents
        let navVC = UINavigationController(rootViewController: ViewControllerFactory(rootURL: getDocumentsURL(), viewTitle: getDocumentsURL().lastPathComponent))
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
        return true
    }
}


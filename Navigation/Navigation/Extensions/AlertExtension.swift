//
//  AlertExtension.swift
//  Navigation
//
//  Created by Artur Skaliy on 11.10.2022.
//

import Foundation
import UIKit
//Расширение, которое позволяет вызвать Alert на текущем (показываемом) UIViewController
extension UIApplication {
    
    var keyWindowInConnectedScenes: UIWindow? {
        return windows.first(where: { $0.isKeyWindow })
    }
    
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindowInConnectedScenes?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}

// Шаблон функции вызова Alert для ошибок с одним Action
class AlertErrorSample {
    
    static let shared = AlertErrorSample()
    
    func alert(alertTitle: String, alertMessage: String) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let actionOne = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(actionOne)
        UIApplication.topViewController()!.present(alert, animated: true, completion: nil)
    }
}

//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Artur Skaliy on 21.09.2022.
//

import Foundation
import UIKit

final class ProfileViewModel {
   
    let profileHeaderView = ProfileHeaderView()
    var postsData: [ProfilePostModel] = []
    var currentUser: User
    init(currentUser: User) {
        self.currentUser = currentUser
    }
    
    func setUser() {
        do {
            try profileHeaderView.setHeaderUser(userAvatar: currentUser.userAvatar, userFullName: currentUser.userFullName, userStatus: currentUser.userStatus)
        } catch FullNameError.longName {
            alert(message: "Cлишком длинное имя")
        } catch FullNameError.noName {
           alert(message: "Имя отсутствует")
        } catch {
            print("Не известная ошибка")
        }
        
    }
    
    func setPosts() {
        postsData = ProfilePostModel.posts

    }
    
    func alert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .actionSheet)
        let actionOne = UIAlertAction(title: "OK", style: .default)
        alert.addAction(actionOne)
        UIApplication.topViewController()!.present(alert, animated: true, completion: nil)
    }
}
extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
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

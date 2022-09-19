//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Artur Skaliy on 17.09.2022.
//

import Foundation
import UIKit

class ProfileCoordinator {
 
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    func startView() {
        
        let currentUserService = CurrentUserService()
        let profileVC = ProfileViewController(currentUser: currentUserService.user)
        navigationController.pushViewController(profileVC, animated: true)
    }
}

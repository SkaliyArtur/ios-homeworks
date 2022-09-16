//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Artur Skaliy on 17.09.2022.
//

import Foundation
import UIKit

class ProfileCoordinator {
 
    func startView(navCon: UINavigationController?, coordinator: ProfileCoordinator) -> UIViewController {
        
        let currentUserService = CurrentUserService()
        let profileVC = ProfileViewController(currentUser: currentUserService.user, coordinator: coordinator)
        navCon?.pushViewController(profileVC, animated: true)
        return profileVC
    }
}

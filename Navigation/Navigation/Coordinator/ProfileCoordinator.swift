//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Artur Skaliy on 17.09.2022.
//

import Foundation
import UIKit

class ProfileCoordinator {

    let navigationController = UINavigationController()

    func startView() {
        let profileVC = ProfileEditViewController()
        navigationController.pushViewController(profileVC, animated: true)
    }
}

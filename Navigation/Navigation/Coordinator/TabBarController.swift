//
//  TabBarController.swift
//  Navigation
//
//  Created by Artur Skaliy on 16.09.2022.
//

import UIKit

class TabBarController: UITabBarController {

    private let profileVC = Factory(navigationController: UINavigationController(), viewController: .profile)
    private let feedVC = Factory(navigationController: UINavigationController(), viewController: .feed)
    private let postVC = Factory(navigationController: UINavigationController(), viewController: .postFeed)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setControllers()
    }
    
    func setControllers() {
        viewControllers = [
            profileVC.navigationController,
            feedVC.navigationController,
            postVC.navigationController
        ]
    }
}


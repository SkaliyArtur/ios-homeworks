//
//  TabBarController.swift
//  Navigation
//
//  Created by Artur Skaliy on 16.09.2022.
//

import UIKit

class TabBarController: UITabBarController {

    private let proflesViewController = Factory(navigationController: UINavigationController(), viewController: .profile)
    private let feedsViewController = Factory(navigationController: UINavigationController(), viewController: .feeds)
    private let favoritesViewController = Factory(navigationController: UINavigationController(), viewController: .favorites)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setControllers()
        tabBarSetup()
    }
    
    func setControllers() {
        viewControllers = [
            proflesViewController.navigationController,
            feedsViewController.navigationController,
            favoritesViewController.navigationController
        ]
    }
    
    func tabBarSetup() {
        self.tabBar.tintColor = AppConstants.Colors.purpleColorNormal
        if #available(iOS 13.0, *) {
            // ios 13.0 and above
            let appearance = tabBar.standardAppearance
            appearance.shadowImage = nil
            appearance.shadowColor = nil
            appearance.backgroundEffect = nil
            appearance.backgroundColor = AppConstants.Colors.tabBarColor
            tabBar.standardAppearance = appearance
        } else {
            // below ios 13.0
            let image = UIImage()
            tabBar.shadowImage = image
            tabBar.backgroundImage = image
            tabBar.backgroundColor = AppConstants.Colors.tabBarColor
        }
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: AppConstants.UIElements.tabBarLineHeight))
        lineView.backgroundColor = AppConstants.Colors.tabBarBorder
        self.tabBar.addSubview(lineView)
        self.tabBar.backgroundColor = AppConstants.Colors.tabBarBorder
    }
}


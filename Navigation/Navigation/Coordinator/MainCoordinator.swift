//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Artur Skaliy on 15.09.2022.
//

import Foundation
import UIKit

protocol MainCoordinator {
    func startApplication() -> UIViewController
}

class MainCoordinatorImp: MainCoordinator {
    func startApplication() -> UIViewController {
        return TabBarController()
    }


}

//
//  PhotoCoordinator.swift
//  Navigation
//
//  Created by Artur Skaliy on 21.09.2022.
//

import Foundation
import UIKit

class PhotoCoordinator {
 
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    func startView() {
        
        let photoViewController = PhotosViewController()
        photoViewController.title = "Photo Gallery"
        navigationController.pushViewController(photoViewController, animated: true)
    }
}

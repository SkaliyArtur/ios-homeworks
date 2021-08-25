//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Artur Skaliy on 25.08.2021.
//

import UIKit

class ProfileViewController: UIViewController {

    let profileHeaderView = ProfileHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        view.addSubview(profileHeaderView)
        
        
    }
    override func viewWillLayoutSubviews() {
        profileHeaderView.frame.size = self.view.frame.size
        
    }
}

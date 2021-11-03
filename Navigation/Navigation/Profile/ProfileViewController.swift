//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Artur Skaliy on 25.08.2021.
//

import UIKit

class ProfileViewController: UIViewController {

    let profileHeaderView = ProfileHeaderView()
    let newUIButton: UIButton = {
        let button = UIButton()
        button.setTitle("newButton", for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        view.addSubview(profileHeaderView)
        view.addSubview(newUIButton)
        
        
    }
    override func viewWillLayoutSubviews() {
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        newUIButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileHeaderView.leftAnchor.constraint(equalTo: view.leftAnchor),
            profileHeaderView.rightAnchor.constraint(equalTo: view.rightAnchor),
            profileHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileHeaderView.heightAnchor.constraint(equalToConstant: 220),
            
            newUIButton.leftAnchor.constraint(equalTo: view.leftAnchor),
            newUIButton.rightAnchor.constraint(equalTo: view.rightAnchor),
            newUIButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
}

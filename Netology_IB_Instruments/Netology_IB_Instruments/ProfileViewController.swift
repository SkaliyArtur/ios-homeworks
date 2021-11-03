//
//  ProfileViewController.swift
//  Netology_IB_Instruments
//
//  Created by Artur Skaliy on 17.08.2021.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let myView = Bundle.main.loadNibNamed("ProfileView", owner: nil, options: nil)?.first as! ProfileView
        myView.frame = CGRect(x: 15, y: 15, width: view.bounds.width - 30, height: view.bounds.height)
        view.addSubview(myView)
    }

}

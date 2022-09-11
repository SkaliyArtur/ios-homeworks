//
//  LoginInspector.swift
//  Navigation
//
//  Created by Artur Skaliy on 08.09.2022.
//

import UIKit

struct LoginInspector: LoginViewControllerDelegate {
    func delegateCheck(login: String, password: String) -> Bool {
        return Checker.shared.checkerCheck(login: login, password: password)
    }
    
 
}

//
//  CurrentUserService.swift
//  Navigation
//
//  Created by Artur Skaliy on 05.09.2022.
//

import Foundation
import UIKit

class CurrentUserService: UserService {
    
    let user: User = .init(userLogin: "Ivan", userFullName: "Ivanov Ivan Ivanovich", userAvatar: UIImage(named: "batmanAvatar.png")!, userStatus: "Best of the best", userPassword: "123")
    
    func getLogin(userLogin: String, userPassword: String) -> User? {
        
        if userLogin == user.userLogin, userPassword == user.userPassword {
            return user
        }
        else {
            print("не правильный логин или пароль")
            return nil
        }
    }

}

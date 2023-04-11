////
////  TestUserService.swift
////  Navigation
////
////  Created by Artur Skaliy on 06.09.2022.
////
//
//import Foundation
//import UIKit
//
//class TestUserService: UserService {
//    
//    let user: User = .init(userLogin: "Krabs", userFullName: "Mr. Crabs", userAvatar: UIImage(named: "MrKrabs.png")!, userStatus: "Спанч Боб", userPassword: "321")
//    
//    func getLogin(userLogin: String, userPassword: String) -> User? {
//        
//        if userLogin == user.userLogin, userPassword == user.userPassword {
//            return user
//        }
//        else {
//            print("не правильный логин или пароль")
//            return nil
//        }
//    }
//
//}

//
//  Checker.swift
//  Navigation
//
//  Created by Artur Skaliy on 08.09.2022.
//

import UIKit

enum loginError: Error {
    case notCorrect
}


class Checker {
//Задание 4.1: сделал Singleton
    static let shared = Checker()
    
    private var loginSing: String
    private var passwordSing: String
    
    private init() {
        self.loginSing = "Batman"
        self.passwordSing = "12345"
    }
    
    func checkerCheck(login: String, password: String) -> Result<Bool, loginError> {
        if login == loginSing, password == passwordSing {
            return .success(true)
        }
        else {
            return .failure(.notCorrect)
        }
        
    }
}

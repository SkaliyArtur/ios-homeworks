//
//  Checker.swift
//  Navigation
//
//  Created by Artur Skaliy on 08.09.2022.
//

import UIKit

class Checker {
//Задание 4.1: сделал Singleton
    static let shared = Checker()
    
    private var loginSing: String
    private var passwordSing: String
    
    private init() {
        self.loginSing = "Batman"
        self.passwordSing = "12345"
    }
    //Задание 4.1: сделал проверку на совпадение введённых логин/пароля
    func checkerCheck(login: String, password: String) -> Bool {
        if login == loginSing, password == passwordSing {
            print("OK")
            return true
        }
        else {
            print("NE OK")
            return false
        }
        
    }
}

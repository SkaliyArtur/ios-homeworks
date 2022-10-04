//
//  LoginInspector.swift
//  Navigation
//
//  Created by Artur Skaliy on 08.09.2022.
//

import UIKit

struct LoginInspector: LoginViewControllerDelegate {
    func delegateCheck(login: String, password: String) -> Bool {
        switch Checker.shared.checkerCheck(login: login, password: password) {
        case .success(true):
            print("Пара логин пароль - верна")
            return true
        case .failure(loginError.notCorrect):
            print("Не правильный логин или пароль")
            return false
        case .success(false):
            print("Не известная ошибка")
            return false
        }
    }
}

//
//  LoginInspector.swift
//  Navigation
//
//  Created by Artur Skaliy on 08.09.2022.
//

import UIKit

struct LoginInspector: LoginViewControllerDelegate {
    
    func delegateCheck(login: String, password: String) -> Bool {
        //Вызываем проверку
        Navigation.CheckerService.shared.checkCredentials(login: login, password: password)
        //Возвращаем принзак проверки для UIViewController (на основании него он решает открывать следующее Вью или нет
        if Navigation.CheckerService.shared.isSingIn == true {
            return true
        } else {
            return false
        }
    }
//    func delegateCheck(login: String, password: String) -> Bool {
//        switch Checker.shared.checkerCheck(login: login, password: password) {
//        case .success(true):
//            print("Пара логин пароль - верна")
//            return true
//        case .failure(loginError.notCorrect):
//            print("Не правильный логин или пароль")
//            return false
//        case .success(false):
//            print("Не известная ошибка")
//            return false
//        }
//    }
}

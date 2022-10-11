//
//  CheckerService.swift
//  Navigation
//
//  Created by Artur Skaliy on 10.10.2022.
//

import Foundation
import FirebaseAuth

protocol CheckerServiceProtocol {
    func checkCredentials(login: String, password: String)
    func signUp(login: String, password: String)
}

class CheckerService: CheckerServiceProtocol {
    //Синглтон
    static let shared = CheckerService()
    
    //Признак успешного логина
    var isSingIn: Bool = false
    
    func checkCredentials(login: String, password: String) {
        Auth.auth().signIn(withEmail: login, password: password) { [self] result, error in
            if let error = error {
                print("error: \(error)")
                let err = error as NSError
                switch err.code {
                //Если ошибка, что пользователь не найден - предлагаем создать
                case AuthErrorCode.userNotFound.rawValue:
                    let alert = UIAlertController(title: "Пользователь не найден", message: "Хотите создать аккаунт?", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Нет", style: .cancel, handler: {_ in print("Отказ создания аккаунта")}))
                    alert.addAction(UIAlertAction(title: "Да", style: .default, handler: {_ in signUp(login: login, password: password)}))
                    UIApplication.topViewController()!.present(alert, animated: true, completion: nil)
                //Выводим любые другие ошибки
                default:
                    AlertErrorSample.shared.alert(alertTitle: "Ошибка входа", alertMessage: error.localizedDescription)
                }
            } else {
                //Если логин пароль валидны - меня признак логина
                isSingIn = true
            }
        }
    }
    
    func signUp(login: String, password: String) {
            Auth.auth().createUser(withEmail: login, password: password) { result, error in
                if let error = error {
                    //Любые ошибки (например длина пароля)
                    AlertErrorSample.shared.alert(alertTitle: "Ошибка регистрации", alertMessage: error.localizedDescription)
                } else {
                    AlertErrorSample.shared.alert(alertTitle: "Аккаунт создан", alertMessage: "Поздравляем! Ваш аккаунт успешно создан!")
                }
            }
    }
}

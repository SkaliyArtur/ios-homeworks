//
//  FirebaseService..swift
//  Navigation
//
//  Created by Artur Skaliy on 10.10.2022.
//


import Foundation
import FirebaseAuth
import UIKit

protocol FirebaseServiceProtocol {
    func checkCredentials(login: String, password: String, using complition: @escaping (Bool)->())
    func signUp(login: String, password: String)
}
//MARK: Класс для взаимодействия с Firebase
class FirebaseService: FirebaseServiceProtocol {
    //Синглтон
    static let shared = FirebaseService()
    
    //Признак успешного логина
    var isSingIn: Bool = false
    
    //функция проверки данных для авторизации
    func checkCredentials(login: String, password: String, using completionHandler: @escaping (Bool)->()) {
        Auth.auth().signIn(withEmail: login, password: password) { [self] result, error in
            if let error = error {
                print("error: \(error)")
                completionHandler(false)
                let err = error as NSError
                switch err.code {
                //Если ошибка, что пользователь не найден - предлагаем создать
                case AuthErrorCode.userNotFound.rawValue:
                    let alert = UIAlertController(title: "User not found".localized, message: "Do you want to create account?".localized, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "No".localized, style: .cancel, handler: {_ in print("Отказ создания аккаунта")}))
                    //при согласлии, вызываем метод регистрации
                    alert.addAction(UIAlertAction(title: "Yes".localized, style: .default, handler: {_ in signUp(login: login, password: password)}))
                    UIApplication.topViewController()!.present(alert, animated: true, completion: nil)
                //Выводим любые другие ошибки
                default:
                    AlertErrorSample.shared.alert(alertTitle: "Log in error".localized, alertMessage: error.localizedDescription)
                }
            } else {
                //Если логин пароль валидны - меняем признак логина
                isSingIn = true
                completionHandler(true)
            }
        }
    }
    
    //метод регистрации
    func signUp(login: String, password: String) {
            Auth.auth().createUser(withEmail: login, password: password) { result, error in
                if let error = error {
                    //Любые ошибки (например длина пароля)
                    AlertErrorSample.shared.alert(alertTitle: "Registration error".localized, alertMessage: error.localizedDescription)
                } else {
                    //После успешного создания аккаунта - логинемся в таббар
                    AlertErrorSample.shared.alertWithComplition(alertTitle: "Account created".localized, alertMessage: "Account have been created!".localized) {
                        LogInViewController().startTabBar(topView: UIApplication.topViewController()!)
                    }
                }
            }
    }
    
    //метод получения имени пользователя
    func getUserName() -> String? {
        let user = Auth.auth().currentUser
        return user?.displayName ?? "No Name"
    }
    
    //метод сохранения нового имени пользователя
    func saveUserName(userName: String) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = userName
        changeRequest?.commitChanges { error in
          // ...
        }
    }
}

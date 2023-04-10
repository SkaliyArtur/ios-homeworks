//
//  CheckerService.swift
//  Navigation
//
//  Created by Artur Skaliy on 10.10.2022.
//

import Foundation
import FirebaseAuth
import UIKit
import FirebaseFirestore
import FirebaseStorage

protocol CheckerServiceProtocol {
    func checkCredentials(login: String, password: String, using complition: @escaping (Bool)->())
    func signUp(login: String, password: String)
}

class CheckerService: CheckerServiceProtocol {
    //Синглтон
    static let shared = CheckerService()
    
    //Признак успешного логина
    var isSingIn: Bool = false
//    var userName: String = ""
    
    
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
                    alert.addAction(UIAlertAction(title: "Yes".localized, style: .default, handler: {_ in signUp(login: login, password: password)}))
                    UIApplication.topViewController()!.present(alert, animated: true, completion: nil)
                //Выводим любые другие ошибки
                default:
                    AlertErrorSample.shared.alert(alertTitle: "Log in error".localized, alertMessage: error.localizedDescription)
                }
            } else {
                //Если логин пароль валидны - меня признак логина
                isSingIn = true
                completionHandler(true)
                currentUserData(login: login, password: password)
            }
        }
    }
    
    func signUp(login: String, password: String) {
            Auth.auth().createUser(withEmail: login, password: password) { result, error in
                if let error = error {
                    //Любые ошибки (например длина пароля)
                    AlertErrorSample.shared.alert(alertTitle: "Registration error".localized, alertMessage: error.localizedDescription)
                } else {
                    AlertErrorSample.shared.alert(alertTitle: "Account created".localized, alertMessage: "Account have been created!".localized)
                }
            }
    }
    
    func currentUserData(login: String, password: String){
        let user = Auth.auth().currentUser
        print("PHOTO \(user?.photoURL) and ID \(user?.uid)")
    }
    
    func getUserName() -> String? {
        let user = Auth.auth().currentUser
        return user?.displayName ?? "No Name"
    }
    
    func saveUserName(userName: String) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = userName
        changeRequest?.commitChanges { error in
          // ...
        }

    }
    
    func setUsersPhotoURL(withImage: UIImage, andFileName: String) {
        let user = Auth.auth().currentUser
        guard let imageData = withImage.jpegData(compressionQuality: 0.5) else { return }
        let storageRef = Storage.storage().reference()
        let thisUserPhotoStorageRef = storageRef.child("\(user?.uid)").child(andFileName)

        let uploadTask = thisUserPhotoStorageRef.putData(imageData, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                print("error while uploading")
                return
            }

            thisUserPhotoStorageRef.downloadURL { (url, error) in
                print(metadata.size) // Metadata contains file metadata such as size, content-type.
                thisUserPhotoStorageRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        print("an error occured after uploading and then getting the URL")
                        return
                    }

                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.photoURL = downloadURL
                    changeRequest?.commitChanges { (error) in
                        //handle error
                    }
                }
            }
        }
    }
}


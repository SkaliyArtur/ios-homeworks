//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Artur Skaliy on 21.09.2022.
//

import Foundation
import UIKit

class ProfileViewModel {
   
    let profileHeaderView = ProfileHeaderView()
    var postsData: [ProfilePostModel] = []
    var currentUser: User
    init(currentUser: User) {
        self.currentUser = currentUser
    }
    
    func setUser() {
        do {
            try profileHeaderView.setHeaderUser(userAvatar: currentUser.userAvatar, userFullName: currentUser.userFullName, userStatus: currentUser.userStatus)
        } catch FullNameError.longName {
            AlertErrorSample.shared.alert(alertTitle: "Ошибка", alertMessage: "Cлишком длинное имя")
        } catch FullNameError.noName {
            AlertErrorSample.shared.alert(alertTitle: "Ошибка", alertMessage: "Имя отсутствует")
        } catch {
            print("Не известная ошибка")
        }
    }
    
    func setPosts() {
        postsData = ProfilePostModel.posts
    }
}


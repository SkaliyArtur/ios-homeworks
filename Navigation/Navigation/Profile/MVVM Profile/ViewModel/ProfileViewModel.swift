//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Artur Skaliy on 21.09.2022.
//

import Foundation
import UIKit

final class ProfileViewModel {
   
    let profileHeaderView = ProfileHeaderView()
    var postsData: [ProfilePostModel] = []
    var currentUser: User
    init(currentUser: User) {
        self.currentUser = currentUser
    }
    
    func setUser() {
        profileHeaderView.setUser(userAvatar: currentUser.userAvatar, userFullName: currentUser.userFullName, userStatus: currentUser.userStatus)
    }
    
    func setPosts() {
        postsData = ProfilePostModel.posts

    }
}

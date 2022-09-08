//
//  UserService.swift
//  Navigation
//
//  Created by Artur Skaliy on 05.09.2022.
//

import Foundation
import UIKit

protocol UserService {

    func getLogin(userLogin: String, userPassword: String) -> User?

}

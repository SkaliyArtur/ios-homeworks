//
//  RealmLoginModel.swift
//  Navigation
//
//  Created by Artur Skaliy on 08.11.2022.
//

import Foundation
import RealmSwift

class RealmLoginModel: Object {
    @objc dynamic var login = ""
    @objc dynamic var password = ""
    @objc dynamic var isAuthorized = false
}

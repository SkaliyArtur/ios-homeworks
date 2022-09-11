//
//  MyLoginFactory.swift
//  Navigation
//
//  Created by Artur Skaliy on 09.09.2022.
//

import UIKit

struct MyLoginFactory: LoginFactory {
    func makeLoginInspector() -> LoginInspector {
        LoginInspector()
    }
}

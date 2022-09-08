//
//  LoginViewControllerDelegate.swift
//  Navigation
//
//  Created by Artur Skaliy on 08.09.2022.
//

import UIKit
//Задание 4.1: сделал протокол делегата
protocol LoginViewControllerDelegate {
    func delegateCheck(login: String, password: String) -> Bool
}

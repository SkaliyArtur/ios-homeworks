//
//  AppConstants.swift
//  Navigation
//
//  Created by Artur Skaliy on 29.03.2023.
//

import Foundation
import UIKit

//Структуры с константами, которые используются в приложении
struct AppConstants {
    
    //для констрейнтов
    struct ConstraintConstants {
        static let loginLogoTop: CGFloat = 163
        static let loginLogoLeadingTrailing: CGFloat = 85
        static let loginHeight: CGFloat = 74.74
        static let loginWidth: CGFloat = 219.49
        static let loginAuthStackViewTop: CGFloat = 192.26
        static let loginAuthStackViewHeight: CGFloat = 96
        
        static let leadingTrailing: CGFloat = 15
        
    }
    //для файлов из папки Assets
    struct Asssets {
        static let getNewsLogo = "getNewsLogo"
    }
    //для UI элементов
    struct UIElements {
        static let cornerRadius: CGFloat = 4
        static let verticalSpacing: CGFloat = 8
        
        static let emailPlaceHolder = NSLocalizedString("Email", comment: "")
        static let passwordPlaceHolder = NSLocalizedString("Password", comment: "")
        
        static let textFielddBackgroundColor = UIColor.createColor(lightMode: UIColor(red: 0.937, green: 0.953, blue: 0.98, alpha: 1), darkMode: UIColor(red: 0.216, green: 0.224, blue: 0.239, alpha: 1))
        static let textFieldTextColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        static let textFont = UIFont(name: "OpenSans-Regular", size: 16)
        static let textInPlaceHolderView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
    }

}

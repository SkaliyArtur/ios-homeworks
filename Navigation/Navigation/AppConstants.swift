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
        
        //Заменить
        static let elementStandartWidth: CGFloat = 360
        static let elementStandartHeight: CGFloat = 44
        
        static let elementStandartSizes = CGSize(width: 360, height: 44)
        static let avatarSizes = CGSize(width: 100, height: 100)
        
        static let leadingTrailing: CGFloat = 15
        
        
        static let faceIDSizes = CGSize(width: 29, height: 29)
        static let touchIDSizes = CGSize(width: 23.29, height: 29.74)
        static let favoritesSizes = CGSize(width: 22, height: 22)
        
    }
    //для файлов из папки Assets
    struct Asssets {
        static let getNewsLogo = "getNewsLogo"
        static let faceID = "faceID"
        static let touchID = "touchID"
        static let profile = "profile"
        static let feeds = "feeds"
        static let favorites = "favorites"
        static let favoritesFill = "favoritesFill"
        static let defaultAvatar = "defaultAvatar"
        static let editButton = "editButton"
        static let editAvatar = "editAvatar"
        
    }
    //цвета
    struct Colors {
        static let purpleColorNormal = UIColor.createColor(
            lightMode: UIColor(red: 0.558, green: 0.471, blue: 1, alpha: 1),
            darkMode: .white)
        static let purpleColorSelected = UIColor.createColor(
            lightMode: UIColor(red: 0.416, green: 0.361, blue: 0.698, alpha: 1),
            darkMode: UIColor(red: 0.89, green: 0.867, blue: 1, alpha: 1))
        static let colorDisabled = UIColor.createColor(
            lightMode: UIColor(red: 0.839, green: 0.835, blue: 0.882, alpha: 1),
            darkMode: UIColor(red: 0.367, green: 0.36, blue: 0.4, alpha: 1))
        static let darkPurpleSecondaryColorNormal = UIColor(red: 0.58, green: 0.569, blue: 0.671, alpha: 1)
        static let purpleSecondaryColorNormal = UIColor.createColor(
            lightMode: UIColor(red: 0.883, green: 0.888, blue: 1, alpha: 1),
            darkMode: darkPurpleSecondaryColorNormal)
        static let purpleSecondaryColorSelected = UIColor.createColor(
            lightMode: UIColor(red: 0.772, green: 0.777, blue: 0.913, alpha: 1),
            darkMode: UIColor(red: 0.457, green: 0.447, blue: 0.533, alpha: 1))
        static let grayColor = UIColor.createColor(
            lightMode: UIColor(red: 0.937, green: 0.953, blue: 0.98, alpha: 1),
            darkMode: UIColor(red: 0.216, green: 0.224, blue: 0.239, alpha: 1))
        static let colorStandart = UIColor.createColor(
            lightMode: .black,
            darkMode: .white)
        static let colorStandartInverted = UIColor.createColor(
            lightMode: .white,
            darkMode: .black)
        static let tabBarColor = UIColor.createColor(
            lightMode: UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1),
            darkMode: .black)
        static let tabBarBorder = UIColor(red: 0.883, green: 0.888, blue: 1, alpha: 1)
        
    }
    //для UI элементов
    struct UIElements {
        static let cornerRadius: CGFloat = 4
        static let spacingBetweenElements: CGFloat = 8
        static let tabBarLineHeight: CGFloat = 1
        static let tableCellTop: CGFloat = 20
        static let tableCellBottom: CGFloat = -14
        
        static let emailPlaceHolder = NSLocalizedString("Email", comment: "")
        static let passwordPlaceHolder = NSLocalizedString("Password", comment: "")
        static let loginButtonText = NSLocalizedString("Log in", comment: "")
        static let searchForFeedPlaceHolder = NSLocalizedString("Search for feeds", comment: "")
        static let searchForFeedText = NSLocalizedString("Get", comment: "")
        static let statusPlaceHolder = NSLocalizedString("Write for status", comment: "")
        static let setStatusButtonText = NSLocalizedString("Set status", comment: "")
        static let exitButton = NSLocalizedString("Exit", comment: "")
        static let namePlaceHolder = NSLocalizedString("Enter name", comment: "")
        
        static let textFontRegular = UIFont(name: "OpenSans-Regular", size: 16)
        static let textFontBold = UIFont(name: "OpenSans-Bold", size: 16)
        static let feedsTitleSemiBold = UIFont(name: "OpenSans-SemiBold", size: 16)
        static let feedsTextRegular = UIFont(name: "OpenSans-Regular", size: 14)
        static let feedsDateCountryRegular = UIFont(name: "OpenSans-Regular", size: 12)
        static let nameLabelSemiBold = UIFont(name: "OpenSans-SemiBold", size: 20)
        
        static let feedsZeroNumberLines = 0
        static let feedsTextNumberLines = 3
        
        static let tableViewEdges = UIEdgeInsets(top: -35, left: 0, bottom: 0, right: 0)
        
        
    }

}

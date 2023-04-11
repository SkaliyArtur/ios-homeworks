//
//  UIColorExtension.swift
//  Navigation
//
//  Created by Artur Skaliy on 27.01.2023.
//

import Foundation
import UIKit
//Расширение для создания цвета светлой и тёмной тем
extension UIColor {
    static func createColor(lightMode: UIColor, darkMode: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else {
            return lightMode
        }
        return UIColor { (traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .light ? lightMode : darkMode
        }
    }
}
//Расширение для создания изображения в 1 пиксель для заливки фона по цвету
extension UIColor {
    func createOnePixelImage() -> UIImage? {
        let size = CGSize(width: 1, height: 1)
        UIGraphicsBeginImageContext(size)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.setFillColor(cgColor)
        context.fill(CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

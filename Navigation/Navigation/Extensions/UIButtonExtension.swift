//
//  UIButtonExtension.swift
//  Navigation
//
//  Created by Artur Skaliy on 02.04.2023.
//

import Foundation
import UIKit

extension UIButton {
    func setBackground(_ color: UIColor, for state: UIControl.State) {
        setBackgroundImage(color.createOnePixelImage(), for: state)
    }
}

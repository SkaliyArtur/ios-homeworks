//
//  CustomTextField.swift
//  Navigation
//
//  Created by Artur Skaliy on 29.03.2023.
//

import UIKit

class CustomTextField: UITextField {
    
    init(placeHolder: String) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = AppConstants.UIElements.cornerRadius
        self.textColor = AppConstants.Colors.colorStandart
        self.backgroundColor = AppConstants.Colors.grayColor
        self.font = AppConstants.UIElements.textFontRegular
        self.attributedPlaceholder = NSAttributedString(
            string: placeHolder,
            attributes: [NSAttributedString.Key.foregroundColor: AppConstants.Colors.darkPurpleSecondaryColorNormal])
        self.autocapitalizationType = .none
        self.leftViewMode = .always
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

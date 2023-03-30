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
        self.textColor = AppConstants.UIElements.textFieldTextColor
        self.backgroundColor = AppConstants.UIElements.textFielddBackgroundColor
        self.font = AppConstants.UIElements.textFont
        self.autocapitalizationType = .none
        self.leftViewMode = .always
        self.leftView = AppConstants.UIElements.textInPlaceHolderView
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

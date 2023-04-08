//
//  CustomButton.swift
//  Navigation
//
//  Created by Artur Skaliy on 12.09.2022.
//

import UIKit

class CustomButton: UIButton {

    //замыкание, в которое будет передаваться действия для функции нажатия
    var actionHandler: (() -> Void)?
    
    init(title: String, titleColorEnable: UIColor, titleColorDisable: UIColor) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = AppConstants.UIElements.textFontBold
        self.setTitleColor(titleColorEnable, for: .normal)
        self.setTitleColor(titleColorDisable, for: .disabled)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        self.layer.cornerRadius = AppConstants.UIElements.cornerRadius
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //реализовал функцию, в которой будет вызываться действия передаваемые из замыкания
    @objc private func buttonTapped(_: UIButton) {
        actionHandler?()
    }
    
    func setButtonColors() {
        self.setBackground(AppConstants.Colors.purpleColorNormal, for: .normal)
        self.setBackground(AppConstants.Colors.purpleColorSelected, for: .selected)
        self.setBackground(AppConstants.Colors.colorDisabled, for: .disabled)
    }
    
    func setSecondButtonColors() {
        self.setBackground(AppConstants.Colors.purpleSecondaryColorNormal, for: .normal)
        self.setBackground(AppConstants.Colors.purpleSecondaryColorSelected, for: .selected)
        
    }
}

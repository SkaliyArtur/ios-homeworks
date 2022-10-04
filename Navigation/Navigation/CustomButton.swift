//
//  CustomButton.swift
//  Navigation
//
//  Created by Artur Skaliy on 12.09.2022.
//

import UIKit

class CustomButton: UIButton {

    //Задание 6: сделал замыкание, в которое будет передаваться действия для функции нажатия
    var actionHandler: (() -> Void)?
    
    //Задание 6: инициализировал основные параметры кнопки (которые чаще всего употребляются)
    init(title: String, titleColor: UIColor) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Задание 6: реализовал функцию, в которой будет вызываться действия передаваемые из замыкания
    @objc private func buttonTapped(_: UIButton) {
        actionHandler?()
    }
}

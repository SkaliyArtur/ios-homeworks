//
//  CustomUILabel.swift
//  Navigation
//
//  Created by Artur Skaliy on 03.04.2023.
//

import UIKit

class CustomUILabel: UILabel {
    
    init(font: UIFont, lines: Int) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = AppConstants.Colors.colorStandart
        self.font = font
        self.numberOfLines = lines
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

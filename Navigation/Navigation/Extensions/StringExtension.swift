//
//  StringExtension.swift
//  Navigation
//
//  Created by Artur Skaliy on 22.01.2023.
//

import Foundation

extension String {
    //Для локазлизации
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}

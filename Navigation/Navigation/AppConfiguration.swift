//
//  AppConfiguration.swift
//  Navigation
//
//  Created by Artur Skaliy on 04.10.2022.
//

import Foundation
import UIKit

enum AppConfiguration: CaseIterable {
    
    
    typealias AllCases = [AppConfiguration]
    
    case planets(String)
    case vehicles(String)
    case starships(String)
    
    static var allCases: AllCases {
        return [
            .planets("https://swapi.dev/api/people/8"),
            .vehicles("https://swapi.dev/api/vehicles/4/"),
            .starships("https://swapi.dev/api/starships/12/")
        ]
    }
    
    
}

////
////  NetworkService.swift
////  Navigation
////
////  Created by Artur Skaliy on 04.10.2022.
////
//
//import Foundation
//import UIKit
//
//struct NetworkService {
//    
//    static func request(for configuration: AppConfiguration) {
//        
//        switch  configuration {
//        case .planets(let value):
//            guard let url = URL(string: value) else {return}
//            dataTask(url)
//        case .starships(let value):
//            guard let url = URL(string: value) else {return}
//            dataTask(url)
//        case .vehicles(let value):
//            guard let url = URL(string: value) else {return}
//            dataTask(url)
//        }
//    }
//    static func dataTask(_ address: URL) {
//            let session = URLSession.shared
//            let task = session.dataTask(with: address) {data, response, error in
//
//                if let error = error {
//                    print("error: \(error.localizedDescription)") //The Internet connection appears to be offline. Code=-1009
//                } else {
//                    guard let data = data else { return }
//                    let str = String(decoding: data, as: UTF8.self)
//                    print("data: \(str)")
//                    if let httpResponse = response as? HTTPURLResponse {
//                    print("allHeaderFields: \(httpResponse.allHeaderFields), statusCode: \(httpResponse.statusCode)")
//                }
//                }
//            }
//
//            task.resume()
//        }
//}
//
//
//
//
//
//
//

////
////  NewsNetworkService.swift
////  Navigation
////
////  Created by Artur Skaliy on 25.03.2023.
////
//
//import Foundation
//
//struct NewsNetworkService {
//    
//    static func dataTask(_ address: URL) {
//            let session = URLSession.shared
//            let task = session.dataTask(with: address) {data, response, error in
//                if let error = error {
//                    print("error: \(error.localizedDescription)")
//                } else {
//                    guard let data = data else { return }
//                    let str = String(decoding: data, as: UTF8.self)
//                    print("data: \(str)")
//                    if let httpResponse = response as? HTTPURLResponse {
//                    print("allHeaderFields: \(httpResponse.allHeaderFields), statusCode: \(httpResponse.statusCode)")
//                }
//                }
//            }
//            task.resume()
//        }
//}

//
//  JSONService.swift
//  Navigation
//
//  Created by Artur Skaliy on 11.04.2023.
//

import Foundation
import UIKit
class JSONService {
    
    func dataTaskNewsJSONDecoder(searchText: String, using completionHandler: @escaping ([FeedsModel])->()){
        var feeds: [FeedsModel] = []
        guard let urlAddress = AppConstants.APIConfiguration.newsURL else {return}
        guard let urlElement = try? EncryptionService().decryptMessage(encryptedMessage: AppConstants.APIConfiguration.errorMessage, encryptionKey: AppConstants.APIConfiguration.errorData) else {return}
        let session = URLSession.shared
        let group = DispatchGroup()
        guard let url = URL(string: "\(urlAddress)?\(urlElement)&text=\(searchText)") else {return}
        group.enter()
            let task = session.dataTask(with: url) {data, _, error in
                do {
                    guard let data = data else { return }
                    let model = try JSONDecoder().decode(FeedsJSONModel.self, from: data)
                    for news in model.news {
                        feeds.append(.init(
                                        feedsTitle: news.title,
                                        feedsText: news.text,
                                        feedsImage: news.image ?? "getNewsLogo",
                                        feedsDate: news.publishDate))
                    }
                    group.leave()
                } catch let error as NSError {
                        print("error: \(error.localizedDescription) OR \(error)")
                }
            }
            task.resume()
        group.notify(queue: .main) {
            completionHandler(feeds)
            
        }
    }
}

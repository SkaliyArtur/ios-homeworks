//
//  FeedsModel.swift
//  Navigation
//
//  Created by Artur Skaliy on 25.03.2023.
//

import Foundation

public struct FeedsModel: Codable {
    public var feedsTitle: String
    public var feedsText: String
    public var feedsImage: String
    public var feedsDate: String
}

struct FeedsJSONModel: Decodable {
    let offset, number, available: Int
    let news: [FeedsDetailsJSONModel]
}

struct FeedsDetailsJSONModel: Decodable {
    let id: Int
    let title: String
    let text: String
    let url: String
    let image: String?
    let publishDate: String
    let author: String?
    let language: String
    let sourceCountry: String
    let sentiment: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case title, text, url, image
        case publishDate = "publish_date"
        case author, language
        case sourceCountry = "source_country"
        case sentiment
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        text = try container.decode(String.self, forKey: .text)
        url = try container.decode(String.self, forKey: .url)
        self.image = try container.decodeIfPresent(String.self, forKey: .image) ?? "getNewsLogo"
        publishDate = try container.decode(String.self, forKey: .publishDate)
        self.author = try container.decodeIfPresent(String.self, forKey: .author) ?? "No author"
        language = try container.decode(String.self, forKey: .language)
        sourceCountry = try container.decode(String.self, forKey: .sourceCountry)
        sentiment = try container.decode(Double.self, forKey: .sentiment)
    }
}

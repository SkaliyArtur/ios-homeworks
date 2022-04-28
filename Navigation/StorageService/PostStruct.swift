//
//  Post.swift
//  Navigation
//
//  Created by Artur Skaliy on 24.01.2022.
//

import Foundation
public struct PostStruct {
    public var author: String
    public var description: String
    public var image: String
    public var likes: Int
    public var views: Int
    
    public static let posts = [
        PostStruct(author: "stranger777", description: "Terality — автоматически масштабируемая альтернатива Pandas", image: "d7536e0a95c1ba5ecc112c400256dc03.jpg", likes: 123, views: 333),
        PostStruct(author: "RiddleRider", description: "Российский микропроцессор Эльбрус 8с", image: "0f62682d881df17779a441be3a3289ce.jpg", likes: 5, views: 1112),
        PostStruct(author: "AKlimenkov", description: "Интроверты против open space", image: "5071e83260856690d52ee7705ac8b597.jpeg", likes: 1234, views: 213),
        PostStruct(author: "mirhifi", description: "Обсуждение: сможет ли апгрейд сорокалетнего стандарта поменять подход к записи музыки", image: "ce5857c53f2756b83c12f00aa7ca319d.jpg", likes: 777, views: 123),
        PostStruct(author: "Darkerus", description: "Текстовые игры — новый старый инструмент для автора или «Сделаем Текстовые Квесты снова Великими!»", image: "6634a6e8ec1f79e6195e7fb6e13d9b8a.jpeg", likes: 8765, views: 1242)
    ]
    }

//let post1: PostStruct = PostStruct(author: "stranger777"
//, description: "Terality — автоматически масштабируемая альтернатива Pandas", image: "d7536e0a95c1ba5ecc112c400256dc03.jpg", likes: 123, views: 333)
//let post2: PostStruct = PostStruct(author: "RiddleRider"
//, description: "Российский микропроцессор Эльбрус 8с", image: "0f62682d881df17779a441be3a3289ce.jpg", likes: 5, views: 1112)
//let post3: PostStruct = PostStruct(author: "AKlimenkov"
//, description: "Интроверты против open space", image: "5071e83260856690d52ee7705ac8b597.jpeg", likes: 1234, views: 213)
//let post4: PostStruct = PostStruct(author: "mirhifi", description: "Обсуждение: сможет ли апгрейд сорокалетнего стандарта поменять подход к записи музыки", image: "ce5857c53f2756b83c12f00aa7ca319d.jpg", likes: 777, views: 123)
//let post5: PostStruct = PostStruct(author: "Darkerus"
//, description: "Текстовые игры — новый старый инструмент для автора или «Сделаем Текстовые Квесты снова Великими!»", image: "6634a6e8ec1f79e6195e7fb6e13d9b8a.jpeg", likes: 8765, views: 1242)
//
//var posts: [PostStruct] = [post1, post2, post3, post4, post5]




//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Artur Skaliy on 25.08.2021.
//

import UIKit


class ProfileViewController: UIViewController {
    
    struct Post {
            var author: String
            var description: String
            var image: String
            var likes: Int
            var views: Int
        }
    var posts: [Post] = []
    
    
    
    

    let tableView = UITableView.init(frame: .zero, style: .plain)
    let profileHeaderView = ProfileHeaderView()
//    let newUIButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("newButton", for: .normal)
//        button.backgroundColor = .orange
//        button.layer.cornerRadius = 4
//        button.layer.shadowOffset = CGSize(width: 4, height: 4)
//        button.layer.shadowRadius = 4
//        button.layer.shadowColor = UIColor.black.cgColor
//        button.layer.shadowOpacity = 0.7
//        return button
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let post1: Post = Post(author: "stranger777"
    , description: "Terality — автоматически масштабируемая альтернатива Pandas", image: "d7536e0a95c1ba5ecc112c400256dc03.jpg", likes: 123, views: 333)
        let post2: Post = Post(author: "RiddleRider"
    , description: "Российский микропроцессор Эльбрус 8с", image: "0f62682d881df17779a441be3a3289ce.jpg", likes: 5, views: 1112)
        let post3: Post = Post(author: "AKlimenkov"
    , description: "Интроверты против open space", image: "5071e83260856690d52ee7705ac8b597.jpeg", likes: 1234, views: 213)
        let post4: Post = Post(author: "mirhifi", description: "Обсуждение: сможет ли апгрейд сорокалетнего стандарта поменять подход к записи музыки", image: "ce5857c53f2756b83c12f00aa7ca319d.jpg", likes: 777, views: 123)
        let post5: Post = Post(author: "Darkerus"
    , description: "Текстовые игры — новый старый инструмент для автора или «Сделаем Текстовые Квесты снова Великими!»", image: "6634a6e8ec1f79e6195e7fb6e13d9b8a.jpeg", likes: 8765, views: 1242)
        
        posts = [post1, post2, post3, post4, post5]
        
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostTableViewCell")
        
        view.backgroundColor = .lightGray
        
        view.addSubview(tableView)
        
        
        
//        view.addSubview(profileHeaderView)
//        view.addSubview(newUIButton)
//        profileHeaderView.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
//        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
//        newUIButton.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            profileHeaderView.leftAnchor.constraint(equalTo: view.leftAnchor),
//            profileHeaderView.rightAnchor.constraint(equalTo: view.rightAnchor),
//            profileHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            profileHeaderView.heightAnchor.constraint(equalToConstant: 220),
//
//            newUIButton.leftAnchor.constraint(equalTo: view.leftAnchor),
//            newUIButton.rightAnchor.constraint(equalTo: view.rightAnchor),
//            newUIButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
//        ])
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    override func viewWillLayoutSubviews() {
        
        
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
        cell.textLabel?.text  = posts[indexPath.row].author
        return cell
    }
    private func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView {
        return profileHeaderView
    }
    
    
}
extension ProfileViewController: UITableViewDelegate {
    
}



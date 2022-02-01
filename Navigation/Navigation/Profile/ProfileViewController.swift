//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Artur Skaliy on 25.08.2021.
//

import UIKit


class ProfileViewController: UIViewController {
    
    let tableView = UITableView.init(frame: .zero, style: .grouped)
    let profileHeaderView = ProfileHeaderView()
    
    private var postsData: [PostStruct] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        view.addSubview(tableView)
        
        postsData = PostStruct.posts
        
        setupTableView()
    }
    func setupTableView() {
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostTableViewCell")
        tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: "ProfileHeaderView")
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ProfileViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
        
//        let pos = posts[indexPath.row]
        
// Вариант применения значений ячейки через didSet
        
        cell.post = postsData[indexPath.row]
        
//        cell.authorLablel.text = pos.author
//        cell.descriptionLablel.text = pos.description
//        cell.imageImageView.image = UIImage(named: pos.image)
//        cell.likesLablel.text = "Likes: \(pos.likes)"
//        cell.viewsLablel.text = "Views: \(pos.views)"
        
        return cell
    }
    
    
}
    
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ProfileHeaderView") as! ProfileHeaderView
        return view
    }
}



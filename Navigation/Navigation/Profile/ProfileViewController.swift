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
        
        
        
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostTableViewCell")
        tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: "ProfileHeaderView")
        
        
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
}

extension ProfileViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
        
        let pos = posts[indexPath.row]
        
// Вариант применения значений ячейки через didSet
        
//        cell.post = posts[indexPath.row]
        
        cell.authorLablel.text = pos.author
        cell.descriptionLablel.text = pos.description
        cell.imageImageView.image = UIImage(named: pos.image)
        cell.likesLablel.text = "Likes: \(pos.likes)"
        cell.viewsLablel.text = "Views: \(pos.views)"
        
        return cell
    }
    
    
}
    
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ProfileHeaderView") as! ProfileHeaderView
        return view
    }
}



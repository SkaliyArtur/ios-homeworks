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
   
    
    var postsData: [PostStruct] = []
    
//    private var tapAvatar: UITapGestureRecognizer = {
//       let tap = UITapGestureRecognizer()
//        tap.numberOfTapsRequired = 1
//        tap.addTarget(ProfileHeaderView.self, action: #selector(tapProcess))
//
//        return tap
//    }()
    
    @objc private func tapProcess() {
        print("TEST")
//        NSLayoutConstraint.activate([
//                                        profileHeaderView.avatarImageView.centerYAnchor.constraint(equalTo: tableView.centerYAnchor),
//                                        profileHeaderView.avatarImageView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor)
//        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray6
        
        view.addSubview(tableView)
        
        
        
        postsData = PostStruct.posts
     
        setupTableView()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setupTableView() {
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostTableViewCell")
        tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: "ProfileHeaderView")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosTableViewCell")
        
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

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 0
        case 1:
            return 1
        case 2:
            return postsData.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell!
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell

            cell.post = postsData[indexPath.row]
            return cell
        }
        if indexPath.section == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: "PhotosTableViewCell", for: indexPath) as! PhotosTableViewCell
        }
            return cell
//        let pos = posts[indexPath.row]
        
// Вариант применения значений ячейки через didSet
        
        
//        cell.authorLablel.text = pos.author
//        cell.descriptionLablel.text = pos.description
//        cell.imageImageView.image = UIImage(named: pos.image)
//        cell.likesLablel.text = "Likes: \(pos.likes)"
//        cell.viewsLablel.text = "Views: \(pos.views)"
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let photoViewController = PhotosViewController()
            photoViewController.title = "Photo Gallery"
            navigationController?.pushViewController(photoViewController, animated: true)

        }
        
    }
}
    
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ProfileHeaderView") as! ProfileHeaderView
        if section == 0 {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapProcess))
            view.avatarImageView.addGestureRecognizer(tapGesture)
            return view
        }
        else {
            return nil
        }
    }
}



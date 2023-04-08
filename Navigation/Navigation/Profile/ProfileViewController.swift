//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Artur Skaliy on 25.08.2021.
//

import UIKit
//import StorageService
import FirebaseAuth

public struct profileSettingsModel: Codable {
    public var setting: String


    public static let settings = [
        profileSettingsModel(setting: "Profile"), profileSettingsModel(setting: "Settings"), profileSettingsModel(setting: "Favorites")]
}

class ProfileViewController: UIViewController {

   
//    let profileViewModel = ProfileViewModel(currentUser: .init(userLogin: "Krabs", userFullName: "Mr. Crabs", userAvatar: UIImage(named: "MrKrabs.png")!, userStatus: "1", userPassword: "1"))
    
    let profileHeaderView = ProfileHeaderView()
    
    let profileTableView = UITableView.init(frame: .zero, style: .grouped)

//    let photoCoordinator = PhotoCoordinator(navigationController: UINavigationController())
//    let coreDataService = CoreDataService()
    
//    init(photoCoordinator: PhotoCoordinator, profileViewModel: ProfileViewModel) {
//        self.photoCoordinator = photoCoordinator
//        self.profileViewModel = profileViewModel
//        super.init(nibName: nil, bundle: nil)
//    }
//    let profileHeaderView = ProfileHeaderView()
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    var timeOutCounter = 100
//    var timer: Timer?
    
//    var backgroundView: UIView = {
//    let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
//    var closeBtn: UIButton = {
//        let closeBtn = UIButton()
//        let img1 = UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
//        closeBtn.setImage(img1, for: .normal)
//        closeBtn.tintColor = .white
//        closeBtn.translatesAutoresizingMaskIntoConstraints = false
//        closeBtn.alpha = 0
//        closeBtn.addTarget(self, action: #selector(closeAvatar), for: .touchUpInside)
//        return closeBtn
//    }()
    
//    var getBtn: UIButton = {
//        let closeBtn = UIButton()
//        let img1 = UIImage(systemName: "newspaper")
//        closeBtn.setImage(img1, for: .normal)
//        closeBtn.tintColor = .black
//        closeBtn.translatesAutoresizingMaskIntoConstraints = false
//        closeBtn.addTarget(self, action: #selector(getNews), for: .touchUpInside)
//        return closeBtn
//    }()
    
    
    
//    @objc func getNews() {
////        dataTaskNewsJSONDecoder()
//        print("Button TAPPED")
//
//    }
    
    
    
//    func setupBackgroundView() {
//        view.addSubview(backgroundView)
//        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
//        backgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//        backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//        backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//
//        backgroundView.addSubview(profileViewModel.profileHeaderView.avatarImageView)
//
//        backgroundView.addSubview(closeBtn)
//        closeBtn.topAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
//        closeBtn.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -15).isActive = true
//    }
    
//    @objc private func tapProcess() {
//        let avatar = profileViewModel.profileHeaderView.avatarImageView
//        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
//            self.setupBackgroundView()
//            if UIDevice.current.orientation.isPortrait{
//            NSLayoutConstraint.activate([
//                avatar.widthAnchor.constraint(equalTo: self.view.widthAnchor),
//                avatar.heightAnchor.constraint(equalTo: self.view.widthAnchor),
//                avatar.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
//                avatar.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            ])
//            }
//            else {
//                NSLayoutConstraint.activate([
//                    avatar.widthAnchor.constraint(equalTo: self.view.heightAnchor),
//                    avatar.heightAnchor.constraint(equalTo: self.view.heightAnchor),
//                    avatar.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
//                    avatar.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//                ])
//            }
//            self.view.layoutIfNeeded()
//        } completion: { finished in
//            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
//                self.closeBtn.alpha = 1
//                self.profileViewModel.profileHeaderView.avatarImageView.layer.cornerRadius = 0
//            }
//        }
//    }
    

//    @objc private func closeAvatar() {
//
//        print("closed")
//
//        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
//                self.closeBtn.alpha = 0
//            self.profileViewModel.profileHeaderView.avatarImageView.layer.cornerRadius = 110/2
//            self.view.layoutIfNeeded()
//        } completion: { finished in
//            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
//                self.profileViewModel.profileHeaderView.addSubview(self.profileViewModel.profileHeaderView.avatarImageView)
//
//                self.profileViewModel.profileHeaderView.avatarImageView.leftAnchor.constraint(equalTo: self.profileViewModel.profileHeaderView.leftAnchor, constant: 16).isActive = true
//                self.profileViewModel.profileHeaderView.avatarImageView.topAnchor.constraint(equalTo: self.profileViewModel.profileHeaderView.topAnchor, constant: 16).isActive = true
//                self.profileViewModel.profileHeaderView.avatarImageView.widthAnchor.constraint(equalToConstant: 110).isActive = true
//                self.profileViewModel.profileHeaderView.avatarImageView.heightAnchor.constraint(equalToConstant: 110).isActive = true
//                self.backgroundView.removeFromSuperview()
//
//                self.view.layoutIfNeeded()
//            }
//        }
//    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = AppConstants.Colors.colorStandartInverted
        
        view.addSubview(profileTableView)
//        view.addSubview(getBtn)
//        profileViewModel.setUser()
//        profileViewModel.setPosts()
        setupTableView()
//        createTimer()
        
    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: animated)
//
//        //Если выходим с профиля - считаем что пользователь разлогинелся
//        do {
//            try Auth.auth().signOut()
//            CheckerService.shared.isSingIn = false
//        } catch {
//            print("Неизвестная ошибка")
//        }
//    }
    
    func setupTableView() {
//        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostTableViewCell")
        profileTableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: "ProfileHeaderView")
//        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosTableViewCell")
//
        profileTableView.backgroundColor = AppConstants.Colors.colorStandartInverted
        profileTableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        
        profileTableView.translatesAutoresizingMaskIntoConstraints = false
        
        profileTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        profileTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        profileTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        profileTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        profileTableView.dataSource = self
        profileTableView.delegate = self
        
//        profileTableView.sectionHeaderHeight = 212
    }
}

extension ProfileViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 0
        case 1:
            return profileSettingsModel.settings.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
//        var cell: UITableViewCell!
//        if indexPath.section == 2 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! FeedsTableViewCell
////            cell.post = profileViewModel.postsData[indexPath.row]
////            let tap = UITapGestureRecognizer(target: self, action: #selector(addPost))
////            tap.numberOfTapsRequired = 2
////            cell.addGestureRecognizer(tap)
//            return cell
//        }
        if indexPath.section == 1 {
            cell.textLabel?.text = profileSettingsModel.settings[indexPath.row].setting
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.section == 1 {
////            photoCoordinator.startView()
//        }
    }

}
    
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
//            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapProcess))
//            self.profileViewModel.profileHeaderView.avatarImageView.addGestureRecognizer(tapGesture)
            return profileHeaderView
        }
        else {
            return nil
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width: profileHeaderView.frame.size.width, height: profileHeaderView.frame.size.height))
            
            return
        }
        else {
            return 0
        }
    }
}

class TableViewCell: UITableViewCell {

}

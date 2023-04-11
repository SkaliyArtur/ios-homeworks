//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Artur Skaliy on 25.08.2021.
//

import UIKit
import FirebaseAuth

public struct profileSettingsModel: Codable {
    public var setting: String


    public static let settings = [
        profileSettingsModel(setting: "Profile"), profileSettingsModel(setting: "Settings"), profileSettingsModel(setting: "Favorites")]
}

class ProfileViewController: UIViewController, editDelegate {
    
    let profileHeaderView = ProfileHeaderView()
    
    let profileTableView = UITableView.init(frame: .zero, style: .grouped)

    var exitButton = CustomButton(title: AppConstants.UIElements.exitButton, titleColorEnable: AppConstants.Colors.colorStandartInverted, titleColorDisable: AppConstants.Colors.darkPurpleSecondaryColorNormal)
 
    var checkerService = FirebaseService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = AppConstants.Colors.colorStandartInverted
        
        view.addSubview(profileTableView)
        view.addSubview(exitButton)
        setupExitButton()
        setupTableView()
        exitButton.actionHandler = { [weak self] in
            guard let self = self else { return }
            self.tapExitButton()
        }
    }
        
    func tapExitButton() {
      do {
        try Auth.auth().signOut()
        FirebaseService.shared.isSingIn = false
        self.view.window?.rootViewController = MainCoordinatorImp().startApplication()
        self.view.window?.makeKeyAndVisible()
      } catch {
        print("Неизвестная ошибка")
      }
    }
        func editButton() {
            let profileVC = ProfileEditViewController()
            self.navigationController?.pushViewController(profileVC, animated: true)
        }
    
    override func viewDidLayoutSubviews() {
        exitButton.setButtonColors()
        ProfileSettingTableViewCell().separatorLineImageView.image = UIColor.createOnePixelImage(AppConstants.Colors.purpleSecondaryColorNormal)()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.profileTableView.reloadData()
        self.view.layoutSubviews()
    }
    
    func setupTableView() {
        profileTableView.register(ProfileSettingTableViewCell.self, forCellReuseIdentifier: "ProfileSettingTableViewCell")
        profileTableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: "ProfileHeaderView")
        
        
        profileTableView.backgroundColor = AppConstants.Colors.colorStandartInverted
        
        profileTableView.translatesAutoresizingMaskIntoConstraints = false
        
        profileTableView.separatorStyle = .none
        profileTableView.rowHeight = 44
        
        
        profileTableView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        profileTableView.widthAnchor.constraint(equalToConstant: AppConstants.ConstraintConstants.elementStandartSizes.width).isActive = true
        profileTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        profileTableView.bottomAnchor.constraint(equalTo: exitButton.topAnchor).isActive = true

        profileTableView.dataSource = self
        profileTableView.delegate = self
    }
    
    func setupExitButton() {
        exitButton.setButtonColors()
        NSLayoutConstraint.activate([
            exitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -AppConstants.UIElements.tableCellTop),
            exitButton.heightAnchor.constraint(equalToConstant: AppConstants.ConstraintConstants.elementStandartSizes.height),
            exitButton.widthAnchor.constraint(equalToConstant: AppConstants.ConstraintConstants.elementStandartSizes.width),
            exitButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
}

extension ProfileViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return profileSettingsModel.settings.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileSettingTableViewCell", for: indexPath) as! ProfileSettingTableViewCell
        cell.settingLabel.text = profileSettingsModel.settings[indexPath.row].setting
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
    }

}
    
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = profileHeaderView
        //инициализировали делегата, чтобы по нажатию открывалась другая вью
        header.deleagate = self
       
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 272
    }
}

class TableViewCell: UITableViewCell {
    
}

//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Artur Skaliy on 25.08.2021.
//

import UIKit


enum FullNameError: Error {
    case noName
    case longName
    case notEnglish
}

class ProfileHeaderView: UITableViewHeaderFooterView {

//     var avatarHeight: NSLayoutConstraint!
//     var avatarWidth: NSLayoutConstraint!
//    let userDefault: User = .init(userLogin: "Krabs", userFullName: "Mr. Crabs", userAvatar: UIImage(named: "MrKrabs.png")!, userStatus: "Спанч Боб", userPassword: "321")
    
    let avatarImageView: UIImageView = {
        let image = UIImageView()
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.white.cgColor
//        image.image = UIImage(named: "MrKrabs.png")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        image.layer.masksToBounds = false
        image.clipsToBounds = true
        return image
    }()
    let fullNameLabel: UILabel = {
        let nameLabel = UILabel()
//        nameLabel.text = "Mr. Crabs"
        nameLabel.textColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        nameLabel.textAlignment = NSTextAlignment.center
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    let statusLabel: UILabel = {
        let statusLabel = UILabel()
//        statusLabel.text = "empty"
        statusLabel.textColor = UIColor.createColor(lightMode: .gray, darkMode: .white)
        statusLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        return statusLabel
    }()
    let statusTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " Waiting for status".localized
        textField.textColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        textField.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .systemGray4)
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    //Задание 6: применил кастомную кнопку, сократил 4 строк кода ниже
    let setStatusButton: UIButton = {
        let statusButton = UIButton()
//        statusButton.setTitle("Set status", for: .normal)
        statusButton.backgroundColor = .systemBlue
//        statusButton.layer.cornerRadius = 4
        statusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        statusButton.layer.shadowRadius = 4
        statusButton.layer.shadowColor = UIColor.black.cgColor
        statusButton.layer.shadowOpacity = 0.7
//        statusButton.translatesAutoresizingMaskIntoConstraints = false
//        statusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return statusButton
    }()

    
    //Задание 6: переделываю функцию, которая должна вызываться и передавать действия по нажатию кнопки
    func buttonPressed() {
//        setStatusButton.actionHandler = { [self] in
//        statusLabel.text = statusTextField.text
//        }
    }
    
    
    //для Задания 3: убрал предустоновленные значения профиля и сделал метод setUser, который присваивает значения свойствам профиля
    func setHeaderUser(userAvatar: UIImage, userFullName: String, userStatus: String ) throws {
        avatarImageView.image = userAvatar
        statusLabel.text = userStatus
        switch  userFullName.count {
        case _ where userFullName.count == 0:
            throw FullNameError.noName
        case _ where userFullName.count > 10:
            throw FullNameError.longName
        default:
            fullNameLabel.text = userFullName
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupProfileHeaderView()
        buttonPressed()
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.layer.cornerRadius = 110/2
        avatarImageView.clipsToBounds = true
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
}
   
    func setupProfileHeaderView() {
        
        contentView.addSubview(fullNameLabel)
        contentView.addSubview(statusLabel)
        contentView.addSubview(statusTextField)
        contentView.addSubview(setStatusButton)
        contentView.addSubview(avatarImageView)
        
//        avatarWidth = avatarImageView.widthAnchor.constraint(equalToConstant: 110)
//        avatarHeight = avatarImageView.heightAnchor.constraint(equalToConstant: 110)

//        NSLayoutConstraint.activate([avatarWidth, avatarHeight])
        
        NSLayoutConstraint.activate([
            avatarImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalToConstant: 110),
            avatarImageView.heightAnchor.constraint(equalToConstant: 110),

            
            fullNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            fullNameLabel.centerYAnchor.constraint(equalTo: contentView.topAnchor, constant: 27),
            
            setStatusButton.topAnchor .constraint(equalTo: avatarImageView.bottomAnchor, constant: 32),
            setStatusButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            setStatusButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50),
            setStatusButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            statusLabel.topAnchor.constraint(equalTo: fullNameLabel.topAnchor, constant: 34),
            statusLabel.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 16),
            
            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 16),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            statusTextField.leftAnchor.constraint(equalTo: statusLabel.leftAnchor),
            statusTextField.rightAnchor.constraint(equalTo: setStatusButton.rightAnchor)
            
        ])
    }
}

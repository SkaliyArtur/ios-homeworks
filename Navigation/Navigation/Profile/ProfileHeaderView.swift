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
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        image.layer.masksToBounds = false
        image.layer.cornerRadius = 100/2
        image.clipsToBounds = true
        return image
    }()
    
    let nameLabel = CustomUILabel(font: AppConstants.UIElements.nameLabelSemiBold!, lines: AppConstants.UIElements.feedsZeroNumberLines)
    
//        : UILabel = {
//        let label = UILabel()
////        nameLabel.text = "Mr. Crabs"
//        label.textColor = UIColor.createColor(lightMode: .black, darkMode: .white)
//        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
//        label.textAlignment = NSTextAlignment.center
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
    let statusLabel = CustomUILabel(font: AppConstants.UIElements.textFontRegular!, lines: AppConstants.UIElements.feedsZeroNumberLines)
//        : UILabel = {
//        let label = UILabel()
////        statusLabel.text = "empty"
//        label.textColor = UIColor.createColor(lightMode: .gray, darkMode: .white)
//        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
    let statusTextField = CustomTextField(placeHolder: AppConstants.UIElements.statusPlaceHolder)
        
//        : UITextField = {
//        let textField = UITextField()
//        textField.placeholder = " Waiting for status".localized
//        textField.textColor = UIColor.createColor(lightMode: .black, darkMode: .white)
//        textField.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .systemGray4)
//        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
//        textField.layer.cornerRadius = 12
//        textField.layer.borderWidth = 1
//        textField.layer.borderColor = UIColor.black.cgColor
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        return textField
//    }()
    
    //Задание 6: применил кастомную кнопку, сократил 4 строк кода ниже
    let setStatusButton = CustomButton(title: AppConstants.UIElements.setStatusButtonText, titleColorEnable: AppConstants.Colors.colorStandart, titleColorDisable: AppConstants.Colors.colorStandart)
    
    let editImageView: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "edit")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
        
//        : UIButton = {
//        let statusButton = UIButton()
////        statusButton.setTitle("Set status", for: .normal)
//        statusButton.backgroundColor = .systemBlue
////        statusButton.layer.cornerRadius = 4
//        statusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
//        statusButton.layer.shadowRadius = 4
//        statusButton.layer.shadowColor = UIColor.black.cgColor
//        statusButton.layer.shadowOpacity = 0.7
////        statusButton.translatesAutoresizingMaskIntoConstraints = false
////        statusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
//        return statusButton
//    }()

    
    //Задание 6: переделываю функцию, которая должна вызываться и передавать действия по нажатию кнопки
    func buttonPressed() {
        
        print("set status")
        setStatusButton.actionHandler = { [self] in
        statusLabel.text = statusTextField.text
        }
    }
    
    
    //для Задания 3: убрал предустоновленные значения профиля и сделал метод setUser, который присваивает значения свойствам профиля
//    func setHeaderUser(userAvatar: UIImage, userFullName: String, userStatus: String ) throws {
//        avatarImageView.image = userAvatar
//        statusLabel.text = userStatus
//        switch  userFullName.count {
//        case _ where userFullName.count == 0:
//            throw FullNameError.noName
//        case _ where userFullName.count > 10:
//            throw FullNameError.longName
//        default:
//            nameLabel.text = userFullName
//        }
//    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupProfileHeaderView()
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setStatusButton.setSecondButtonColors()
//        avatarImageView.layer.cornerRadius = 110/2
//        avatarImageView.clipsToBounds = true
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
}
   
    func setupProfileHeaderView() {
        
        contentView.backgroundColor = AppConstants.Colors.colorStandartInverted
        contentView.addSubview(avatarImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(statusLabel)
        contentView.addSubview(statusTextField)
        contentView.addSubview(setStatusButton)
        contentView.addSubview(editImageView)
        
        avatarImageView.image = UIImage(named: "defaultAvatar")
        nameLabel.text = "Name"
        statusLabel.text = "Status"
        setStatusButton.setSecondButtonColors()
        
        NSLayoutConstraint.activate([
            
            statusTextField.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 116),
            statusTextField.centerXAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerXAnchor),
            statusTextField.widthAnchor.constraint(equalToConstant: AppConstants.ConstraintConstants.elementStandartSizes.width),
            statusTextField.heightAnchor.constraint(equalToConstant: AppConstants.ConstraintConstants.elementStandartSizes.height),
            
            setStatusButton.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: AppConstants.UIElements.spacingBetweenElements),
            setStatusButton.leadingAnchor.constraint(equalTo: statusTextField.leadingAnchor),
            setStatusButton.trailingAnchor.constraint(equalTo: statusTextField.trailingAnchor),
            setStatusButton.heightAnchor.constraint(equalToConstant: AppConstants.ConstraintConstants.elementStandartSizes.height),
            
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: statusTextField.leadingAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: AppConstants.ConstraintConstants.avatarSizes.width),
            avatarImageView.heightAnchor.constraint(equalToConstant: AppConstants.ConstraintConstants.avatarSizes.height),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 21.5),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 20),
            
            statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: AppConstants.UIElements.spacingBetweenElements),
            statusLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            editImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            editImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}

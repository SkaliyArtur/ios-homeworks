//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Artur Skaliy on 25.08.2021.
//

import UIKit

protocol editDelegate {
    func editButton()
}

class ProfileHeaderView: UITableViewHeaderFooterView {
    
    
    var deleagate: editDelegate?
    
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
    
    let statusLabel = CustomUILabel(font: AppConstants.UIElements.textFontRegular!, lines: AppConstants.UIElements.feedsZeroNumberLines)

    let statusTextField = CustomTextField(placeHolder: AppConstants.UIElements.statusPlaceHolder)

    let setStatusButton = CustomButton(title: AppConstants.UIElements.setStatusButtonText, titleColorEnable: AppConstants.Colors.colorStandart, titleColorDisable: AppConstants.Colors.colorStandart)
    
    let editButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapEdit), for: .touchUpInside)
        return button
    }()

    func buttonPressed() {
        statusLabel.text = statusTextField.text
    }
    
    func editButtonSetup(image: UIImage?, height: CGFloat, width: CGFloat) {
        guard let img = image else {return}
        editButton.setBackgroundImage(img.withTintColor(AppConstants.Colors.purpleColorNormal), for: .normal)
        editButton.setBackgroundImage(img.withTintColor(AppConstants.Colors.purpleColorSelected), for: .selected)
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupProfileHeaderView()
        
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setStatusButton.setSecondButtonColors()
        setStatusButton.actionHandler = { [weak self] in
            guard let self = self else { return }
            self.buttonPressed()
        }
        nameLabel.text = FirebaseService.shared.getUserName()
        
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
}
    @objc func tapEdit() {
        
        deleagate?.editButton()
        
    }
    
    func setupProfileHeaderView() {
        
        contentView.backgroundColor = AppConstants.Colors.colorStandartInverted
        contentView.addSubview(avatarImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(statusLabel)
        contentView.addSubview(statusTextField)
        contentView.addSubview(setStatusButton)
        contentView.addSubview(editButton)
        
        avatarImageView.image = UIImage(named: AppConstants.Asssets.defaultAvatar)
        statusLabel.text = "Status"
        setStatusButton.setSecondButtonColors()
        editButtonSetup(image: UIImage(named: AppConstants.Asssets.editButton), height: 24, width: 24)
        
        
        
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
            
            editButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            editButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    
}

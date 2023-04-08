//
//  ProfileEditViewController.swift
//  Navigation
//
//  Created by Artur Skaliy on 08.04.2023.
//


import UIKit

class ProfileEditViewController: UIViewController {
    
    let avatarImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        image.layer.masksToBounds = false
        image.layer.cornerRadius = 100/2
        image.clipsToBounds = true
        return image
    }()
    
    let nameTextField = CustomTextField(placeHolder: AppConstants.UIElements.namePlaceHolder)

    let saveButton = CustomButton(title: AppConstants.UIElements.setStatusButtonText, titleColorEnable: AppConstants.Colors.colorStandartInverted, titleColorDisable: AppConstants.Colors.colorStandart)
    
    let closeButton = CustomButton(title: AppConstants.UIElements.setStatusButtonText, titleColorEnable: AppConstants.Colors.colorStandart, titleColorDisable: AppConstants.Colors.colorStandart)

    override func viewDidLoad() {
        setupProfileEditViewController()
        
        saveButton.actionHandler = { [weak self] in
            guard let self = self else { return }
            self.tapSaveButton()
        }
        
        closeButton.actionHandler = { [weak self] in
            guard let self = self else { return }
            self.tapCloseButton()
        }
    }
   
    
    func tapSaveButton() {
        
    }
    
    func tapCloseButton() {
        self.navigationController?.popViewController(animated: true)
    }
    func setupProfileEditViewController() {
        
        view.backgroundColor = AppConstants.Colors.colorStandartInverted
        view.addSubview(avatarImageView)
        view.addSubview(nameTextField)
        view.addSubview(saveButton)
        view.addSubview(closeButton)
        
        avatarImageView.image = UIImage(named: AppConstants.Asssets.editAvatar)
        
        NSLayoutConstraint.activate([
            
            closeButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            closeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            closeButton.widthAnchor.constraint(equalToConstant: AppConstants.ConstraintConstants.elementStandartSizes.width),
            closeButton.heightAnchor.constraint(equalToConstant: AppConstants.ConstraintConstants.elementStandartSizes.height),
            
            saveButton.leadingAnchor.constraint(equalTo: closeButton.leadingAnchor),
            saveButton.trailingAnchor.constraint(equalTo: closeButton.trailingAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: AppConstants.ConstraintConstants.elementStandartSizes.height),
            
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: closeButton.leadingAnchor),
            
            nameTextField.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor)
        ])
    }
}

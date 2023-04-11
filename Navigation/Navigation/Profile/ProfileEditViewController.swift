//
//  ProfileEditViewController.swift
//  Navigation
//
//  Created by Artur Skaliy on 08.04.2023.
//


import UIKit
import Foundation

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

    let saveButton = CustomButton(title: AppConstants.UIElements.saveButtonText, titleColorEnable: AppConstants.Colors.colorStandartInverted, titleColorDisable: AppConstants.Colors.colorStandart)
    
    let closeButton = CustomButton(title: AppConstants.UIElements.closeButtonText, titleColorEnable: AppConstants.Colors.colorStandart, titleColorDisable: AppConstants.Colors.colorStandart)

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
        
        nameTextField.text = FirebaseService.shared.getUserName()
        
        avatarSetup()
    }
    
    override func viewDidLayoutSubviews() {
        saveButton.setButtonColors()
        closeButton.setSecondButtonColors()
    }
   
    
    func tapSaveButton() {
        FirebaseService.shared.saveUserName(userName: nameTextField.text ?? "No Name")
        let alert = UIAlertController(title: "Profile have changed", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] _ in
            self.navigationController?.popViewController(animated: true)
                }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func tapCloseButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func avatarSetup() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        avatarImageView.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        print("Hello World")
        showImagePickerOptions()
    }
    
    
    func setupProfileEditViewController() {
        
        view.backgroundColor = AppConstants.Colors.colorStandartInverted
        view.addSubview(avatarImageView)
        view.addSubview(nameTextField)
        view.addSubview(saveButton)
        view.addSubview(closeButton)
        
        saveButton.setButtonColors()
        closeButton.setSecondButtonColors()
        nameTextField.font = AppConstants.UIElements.nameLabelSemiBold
        
        avatarImageView.image = UIImage(named: AppConstants.Asssets.editAvatar)
        
        NSLayoutConstraint.activate([
            
            closeButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            closeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            closeButton.widthAnchor.constraint(equalToConstant: AppConstants.ConstraintConstants.elementStandartSizes.width),
            closeButton.heightAnchor.constraint(equalToConstant: AppConstants.ConstraintConstants.elementStandartSizes.height),
            
            saveButton.leadingAnchor.constraint(equalTo: closeButton.leadingAnchor),
            saveButton.trailingAnchor.constraint(equalTo: closeButton.trailingAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: AppConstants.ConstraintConstants.elementStandartSizes.height),
            saveButton.bottomAnchor.constraint(equalTo: closeButton.topAnchor, constant: -AppConstants.UIElements.spacingBetweenElements),
            
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: closeButton.leadingAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            
            nameTextField.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: closeButton.trailingAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: AppConstants.ConstraintConstants.elementStandartSizes.height)
        ])
    }
}

extension ProfileEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePicker(sourceType: UIImagePickerController.SourceType) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        return imagePicker
    }
    
    func showImagePickerOptions() {
        let imagePickerAlert = UIAlertController(title: "Pick a Photo", message: "Choose a picture from Library or camera", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { [weak self] (action) in
            guard let self = self else {return}
            let cameraImagePicker = self.imagePicker(sourceType: .camera)
            cameraImagePicker.delegate = self
            cameraImagePicker.allowsEditing = true
            self.present(cameraImagePicker, animated: true) {
            }
        }
        
        let libraryAction = UIAlertAction(title: "Library", style: .default) { [weak self] (action) in
            guard let self = self else {return}
            let libraryImagePicker = self.imagePicker(sourceType: .photoLibrary)
            libraryImagePicker.delegate = self
            self.present(libraryImagePicker, animated: true) {
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        imagePickerAlert.addAction(cameraAction)
        imagePickerAlert.addAction(libraryAction)
        imagePickerAlert.addAction(cancelAction)
        self.present(imagePickerAlert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        self.avatarImageView.image = image
        self.dismiss(animated: true, completion: nil)
    }
}

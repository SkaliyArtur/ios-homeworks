//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Artur Skaliy on 25.08.2021.
//

import UIKit

class ProfileHeaderView: UIView {
    
    let avatarImageView: UIImageView = {
        let image = UIImageView()
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.white.cgColor
        image.image = UIImage(named: "MrKrabs.png")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = false
        image.clipsToBounds = true
        return image
    }()
    let fullNameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "Mr. Crabs"
        nameLabel.textColor = .black
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        nameLabel.textAlignment = NSTextAlignment.center
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    let statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.text = "empty"
        statusLabel.textColor = .gray
        statusLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        return statusLabel
    }()
    let statusTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Waiting for status"
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let setStatusButton: UIButton = {
        let statusButton = UIButton()
        statusButton.setTitle("Set status", for: .normal)
        statusButton.backgroundColor = .systemBlue
        statusButton.layer.cornerRadius = 4
        statusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        statusButton.layer.shadowRadius = 4
        statusButton.layer.shadowColor = UIColor.black.cgColor
        statusButton.layer.shadowOpacity = 0.7
        statusButton.translatesAutoresizingMaskIntoConstraints = false
        statusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return statusButton
    }()

    @objc func buttonPressed() {
        statusLabel.text = statusTextField.text
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(avatarImageView)
        self.addSubview(fullNameLabel)
        self.addSubview(statusLabel)
        self.addSubview(statusTextField)
        self.addSubview(setStatusButton)
        NSLayoutConstraint.activate([
            avatarImageView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 16),
            avatarImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalToConstant: 110),
            avatarImageView.heightAnchor.constraint(equalToConstant: 110),
            
            fullNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            fullNameLabel.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 27),
            
            setStatusButton.topAnchor .constraint(equalTo: avatarImageView.bottomAnchor, constant: 32),
            setStatusButton.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 16),
            setStatusButton.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -16),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50),
            
            statusLabel.topAnchor.constraint(equalTo: fullNameLabel.topAnchor, constant: 34),
            statusLabel.leftAnchor.constraint(equalTo: fullNameLabel.leftAnchor),
            
            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 16),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            statusTextField.leftAnchor.constraint(equalTo: fullNameLabel.leftAnchor),
            statusTextField.rightAnchor.constraint(equalTo: setStatusButton.rightAnchor)
            
        ])
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height/2
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
}
}

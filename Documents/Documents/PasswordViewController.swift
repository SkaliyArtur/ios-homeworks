//
//  PasswordViewController.swift
//  Documents
//
//  Created by Artur Skaliy on 26.10.2022.
//

import UIKit

class PasswordViewController: UIViewController {
    
    var pass1: String?
    var pass2: String?
    var savedPassword: String?
    let passwordKeychainService = PasswordKeychainSevice()
    
    var toUpdatePassword: Bool
    
    init(toUpdatePassword: Bool) {
        self.toUpdatePassword = toUpdatePassword
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let passwordTextField: UITextField = {
       let text = UITextField()
        text.attributedPlaceholder = NSAttributedString(text: "Ваш пароль", aligment: .center, color: .lightGray)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.layer.borderWidth = 0.5
        text.layer.borderColor = UIColor.lightGray.cgColor
        text.isSecureTextEntry = true
        return text
    }()
    
    let passwordButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemOrange
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    let passwordDeleteButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.lightGray, for: .disabled)
        button.setTitle("Удалить пароль", for: .normal)
        button.addTarget(self, action: #selector(deletePassword), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        passwordTextField.text = nil
        pass1 = nil
        pass2 = nil
        savedPassword = nil
        
        if passwordKeychainService.retrivePassword(credentials: Credentials.init(password: "")).status == errSecItemNotFound || toUpdatePassword == true {
            passwordDeleteButton.isEnabled = false
            passwordButton.setTitle("Создать пароль", for: .normal)
            passwordButton.addTarget(self, action: #selector(firstPasswordEnter), for: .touchUpInside)
            view.reloadInputViews()
        } else {
            passwordDeleteButton.isEnabled = true
            guard let data = passwordKeychainService.retrivePassword(credentials: Credentials.init(password: "")).data else {return}
            savedPassword = String(data: data , encoding: .utf8)
//            print("сохранённый пароль: \(savedPassword)")
            passwordButton.setTitle("Введите пароль", for: .normal)
            passwordButton.addTarget(self, action: #selector(firstPasswordEnter), for: .touchUpInside)
        }
    }
    
    
    @objc private func firstPasswordEnter() {
        guard let text = passwordTextField.text, !text.isEmpty, text.count >= 4  else {
            AlertErrorSample.shared.alert(alertTitle: "Некорректный пароль", alertMessage: "Пароль должен содержать минимум 4 символа")
            return
        }
        pass1 = text
        passwordTextField.text = nil
        passwordButton.removeTarget(self, action: #selector(firstPasswordEnter), for: .touchUpInside)
        passwordButton.setTitle("Повторите пароль", for: .normal)
        passwordButton.addTarget(self, action: #selector(repeatPassword), for: .touchUpInside)
    }
    
    @objc private func repeatPassword() {
        guard let text = passwordTextField.text, !text.isEmpty, text.count >= 4 else {
            AlertErrorSample.shared.alert(alertTitle: "Некорректный пароль", alertMessage: "Пароль должен содержать минимум 4 символа")
            return
        }
        pass2 = text
        guard pass1 == pass2 else {
            passwordButton.removeTarget(self, action: #selector(repeatPassword), for: .touchUpInside)
            AlertErrorSample.shared.alert(alertTitle: "Некорректный пароль", alertMessage: "Введёная пара паролей не совпадает")
            viewWillAppear(true)
            return
        }
        switch savedPassword {
        case nil:
            if toUpdatePassword == true {
                passwordKeychainService.updatePassword(credentials: Credentials.init(password: text))
                dismiss(animated: true, completion: {
                    AlertErrorSample.shared.alert(alertTitle: "Пароль обновлён", alertMessage: "Ваш пароль обновлён в Keychain")
                })
                
            } else {
            passwordKeychainService.savePassword(credentials: Credentials.init(password: text))
            tabBarPresent()
            AlertErrorSample.shared.alert(alertTitle: "Пароль создан", alertMessage: "Ваш пароль создан и сохранён в Keychain")
            }
        case pass2:
            tabBarPresent()
        default:
            passwordButton.removeTarget(self, action: #selector(repeatPassword), for: .touchUpInside)
            AlertErrorSample.shared.alert(alertTitle: "Некорректный пароль", alertMessage: "Пароль не найден")
            viewWillAppear(true)
        }
    }
    
    @objc private func deletePassword() {
        passwordKeychainService.deletePassword(credentials: Credentials.init(password: ""))
        AlertErrorSample.shared.alert(alertTitle: "Пароль удалён", alertMessage: "Ваш пароль удалён из Keychain")
        viewWillAppear(true)
    }
    
    
    func setupView() {
        view.addSubview(passwordTextField)
        view.addSubview(passwordButton)
        NSLayoutConstraint.activate([
            passwordTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            passwordTextField.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            passwordTextField.widthAnchor.constraint(equalToConstant: 200),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            passwordButton.widthAnchor.constraint(equalTo: passwordTextField.widthAnchor),
            passwordButton.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            passwordButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor)
        ])
        setupDeleteButton()
    }
    
    func setupDeleteButton() {
        view.addSubview(passwordDeleteButton)
        NSLayoutConstraint.activate([
            passwordDeleteButton.topAnchor.constraint(equalTo: passwordButton.bottomAnchor, constant: 5),
            passwordDeleteButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    func tabBarPresent() {
        let tabBar = UITabBarController()
        let docVC = ViewControllerFactory(rootURL: getDocumentsURL(), viewTitle: getDocumentsURL().lastPathComponent)
        let docNC = UINavigationController(rootViewController: docVC)
        docNC.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "folder"), tag: 1)
        let setVC = SettingsViewController()
        let setNC = UINavigationController(rootViewController: setVC)
        setNC.tabBarItem = UITabBarItem(title: "Настройки", image: UIImage(systemName: "gear"), tag: 2)
        setVC.delegate = docVC
        tabBar.viewControllers = [docNC, setNC]
        view.window?.rootViewController = tabBar
        view.window?.makeKeyAndVisible()
    }
    
    func getDocumentsURL() -> URL {
        let documentsURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let doucmentsURL = documentsURLs[0]
        return doucmentsURL
    }
   
}

extension NSAttributedString
    {
        convenience init(text: String, aligment: NSTextAlignment, color:UIColor) {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = aligment
            self.init(string: text, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.foregroundColor:color])
        }
    }

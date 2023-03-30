//
//  LogInViewController.swift
//  Navigation
//
//  Created by Artur Skaliy on 20.11.2021.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {
    
    let coordinator: ProfileCoordinator
    
    init(coordinator: ProfileCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let getNewsLogoImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: AppConstants.Asssets.getNewsLogo)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let authStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layer.cornerRadius = AppConstants.UIElements.cornerRadius
        stackView.axis = .vertical
        stackView.spacing = AppConstants.UIElements.verticalSpacing
        stackView.distribution = .fillEqually
        stackView.clipsToBounds = true
        return stackView
    }()
    
    let loginTextField: CustomTextField = {
        let textField = CustomTextField(placeHolder: AppConstants.UIElements.emailPlaceHolder)
        return textField
    }()
    
//    let loginTextField: UITextField = {
//        let textField = UITextField()
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.layer.cornerRadius = AppConstants.UIElements.cornerRadius
//        textField.textColor = AppConstants.UIElements.textFieldTextColor
//        textField.font = UIFont(name: "OpenSans-Regular", size: 16)
//        return textField
//    }()
    
    let passwordTextField: CustomTextField = {
        let textField = CustomTextField(placeHolder: AppConstants.UIElements.passwordPlaceHolder)
        return textField
    }()
    
//    let passwordTextField: UITextField = {
//        let textField = UITextField()
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.layer.cornerRadius = AppConstants.UIElements.cornerRadius
//        textField.textColor = AppConstants.UIElements.textFieldTextColor
//        return textField
//    }()
    
    
    let loginButton: CustomButton = {
        let loginButton = CustomButton(title: NSLocalizedString("Log in", comment: ""), titleColor: .white)
        let img1 = UIImage(named: "blue_pixel")!.alpha(1)
        let img2 = UIImage(named: "blue_pixel")!.alpha(0.8)
        loginButton.setBackgroundImage(img1, for: .normal)
        loginButton.setBackgroundImage(img2, for: .selected)
        loginButton.setBackgroundImage(img2, for: .highlighted)
        loginButton.setBackgroundImage(img2, for: .disabled)
        return loginButton
    }()
    
    let faceIdButton: UIButton = {
        let faceIdButton = UIButton()
        faceIdButton.translatesAutoresizingMaskIntoConstraints = false
        faceIdButton.addTarget(self, action: #selector(faceIdButtonTap), for: .touchUpInside)
        return faceIdButton
    }()
    
    var checkerService: CheckerServiceProtocol?
    var localAuthService: LocalAuthorizationService?
    
    @objc func faceIdButtonTap() {
        localAuthService?.authorizeIfPossible() { doneWorking in
            if doneWorking {
                self.coordinator.startView()
            } else {
                print("LOG IN ERROR")
            }
            
        }
    }

    func tap() {
        //Проверяем, что поля не пустые
        guard let login = self.loginTextField.text, let pass = self.passwordTextField.text, !login.isEmpty, !pass.isEmpty else {
            AlertErrorSample.shared.alert(alertTitle: NSLocalizedString("Fill error", comment: ""), alertMessage: NSLocalizedString("Email and password fields must be filled", comment: ""))
            return
        }
        
    //Вызываем проверку
        checkerService?.checkCredentials(login: login, password: pass) { doneWorking in
            if doneWorking {
                self.coordinator.startView()
            } else {
                
            }
        }
}
    
    let loginScrollView: UIScrollView = {
    let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .black)
        return scrollView
    }()
    
    let contentView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    @objc func keyboardWillShow(Notification: NSNotification) {
        if let keyBoardSize = (Notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            loginScrollView.contentInset.bottom = keyBoardSize.height
            loginScrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyBoardSize.height, right: 0)
        }
    }
    @objc func keyboardWillHide(Notification: NSNotification) {
        loginScrollView.contentInset.bottom = .zero
        loginScrollView.verticalScrollIndicatorInsets = .zero
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidLoad() {
        
        loginTextField.text = "1@1.ru"
        passwordTextField.text = "123456"
        
        view.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .black)
        constraintSetup()
        
        loginButton.actionHandler = { [weak self] in
            guard let self = self else { return }
            self.tap()
        }
    }
    
    func constraintSetup() {
        
        view.addSubview(loginScrollView)
        loginScrollView.addSubview(contentView)
        contentView.addSubview(getNewsLogoImageView)
        contentView.addSubview(authStackView)
        contentView.addSubview(loginButton)
//        authStackView.addSubview(loginTextField)
//        authStackView.addSubview(passwordTextField)
        authStackView.addArrangedSubview(loginTextField)
        authStackView.addArrangedSubview(passwordTextField)
        
        NSLayoutConstraint.activate([
        loginScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
        loginScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        loginScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        loginScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        
        contentView.leadingAnchor.constraint(equalTo: loginScrollView.leadingAnchor),
        contentView.topAnchor.constraint(equalTo: loginScrollView.topAnchor),
        contentView.bottomAnchor.constraint(equalTo: loginScrollView.bottomAnchor),
        contentView.trailingAnchor.constraint(equalTo: loginScrollView.trailingAnchor),
        contentView.widthAnchor.constraint(equalTo: loginScrollView.widthAnchor),
            
        getNewsLogoImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: AppConstants.ConstraintConstants.loginLogoTop),
        getNewsLogoImageView.widthAnchor.constraint(equalToConstant: AppConstants.ConstraintConstants.loginWidth),
        getNewsLogoImageView.heightAnchor.constraint(equalToConstant: AppConstants.ConstraintConstants.loginHeight),
            getNewsLogoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
        authStackView.topAnchor.constraint(equalTo: getNewsLogoImageView.bottomAnchor, constant: AppConstants.ConstraintConstants.loginAuthStackViewTop),
        authStackView.heightAnchor.constraint(equalToConstant: AppConstants.ConstraintConstants.loginAuthStackViewHeight),
        authStackView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: AppConstants.ConstraintConstants.leadingTrailing),
        authStackView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -AppConstants.ConstraintConstants.leadingTrailing),
        ])

        switch localAuthService?.checkBiometryType() {
        case .face:
            faceIdButton.setBackgroundImage(UIImage(systemName: "faceid"), for: .normal)
            buttonSetup()
        case .touch:
            faceIdButton.setBackgroundImage(UIImage(systemName: "touchid"), for: .normal)
            buttonSetup()
        default:
            loginButton.topAnchor.constraint(equalTo: authStackView.bottomAnchor, constant: 16).isActive = true
            loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
            loginButton.leadingAnchor.constraint(equalTo: authStackView.leadingAnchor).isActive = true
            loginButton.trailingAnchor.constraint(equalTo: authStackView.trailingAnchor).isActive = true
            loginButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        }
    }
    func buttonSetup() {
        contentView.addSubview(faceIdButton)
        loginButton.topAnchor.constraint(equalTo: authStackView.bottomAnchor, constant: 16).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: authStackView.leadingAnchor).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: faceIdButton.leadingAnchor, constant: -10).isActive = true
        loginButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        faceIdButton.topAnchor.constraint(equalTo: authStackView.bottomAnchor, constant: 16).isActive = true
        faceIdButton.widthAnchor.constraint(equalToConstant: 55).isActive = true
        faceIdButton.trailingAnchor.constraint(equalTo: authStackView.trailingAnchor).isActive = true
        faceIdButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

    }
    }

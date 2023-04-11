//
//  LogInViewController.swift
//  Navigation
//
//  Created by Artur Skaliy on 20.11.2021.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {
    
    static let shared = LogInViewController()
    
    //MARK: Основные элементы экрана
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
        stackView.spacing = AppConstants.UIElements.spacingBetweenElements
        stackView.distribution = .fillEqually
        stackView.clipsToBounds = true
        return stackView
    }()
    let loginTextField = CustomTextField(placeHolder: AppConstants.UIElements.emailPlaceHolder)
    let passwordTextField = CustomTextField(placeHolder: AppConstants.UIElements.passwordPlaceHolder)
    let loginButton = CustomButton(
            title: AppConstants.UIElements.loginButtonText,
            titleColorEnable: AppConstants.Colors.colorStandartInverted,
            titleColorDisable: AppConstants.Colors.darkPurpleSecondaryColorNormal)
    let authTypeButton: UIButton = {
        let faceIdButton = UIButton()
        faceIdButton.translatesAutoresizingMaskIntoConstraints = false
        faceIdButton.addTarget(self, action: #selector(authTypeButtonTap), for: .touchUpInside)
        return faceIdButton
    }()
    
    //MARK: Инициализация сервисов для проверки логина и биометрии
    var checkerService = FirebaseService()
    var localAuthService = LocalAuthorizationService()
    
    @objc func authTypeButtonTap() {
        localAuthService.authorizeIfPossible() { doneWorking in
            if doneWorking {
                self.startTabBar(topView: self)
            } else {
                print(AppConstants.UIElements.unknownError)
            }
            
        }
    }

    func loginButtonTap() {
        //Проверяем, что поля не пустые, на случай, если логика активности кнопки Log in не работает
        guard let login = loginTextField.text, let pass = passwordTextField.text, !login.isEmpty, !pass.isEmpty else {
            AlertErrorSample.shared.alert(alertTitle: NSLocalizedString("Fill error", comment: ""), alertMessage: NSLocalizedString("Email and password fields must be filled", comment: ""))
            return
        }
        
    //Вызываем проверку
        checkerService.checkCredentials(login: login, password: pass) { doneWorking in
            if doneWorking {
                self.startTabBar(topView: self)
            } else {
                print(AppConstants.UIElements.unknownError)
            }
        }
    }
    
    //Функция перехода на TabBar
    func startTabBar(topView: UIViewController) {
        topView.view.window?.rootViewController = TabBarController()
        topView.view.window?.makeKeyAndVisible()
    }
    //MARK: Вызов основных функий View
    override func viewDidLoad() {
        
        //Автозаполнили поля для удобства тестирования
        loginTextField.text = "1@1.ru"
        passwordTextField.text = "123456"
        
        //Свойства, для правильной работы кнопки Log in
        checkLoginButtonEnable()
        loginTextField.delegate = self
        passwordTextField.delegate = self
        //Скрываем пароль
        passwordTextField.isSecureTextEntry = true
        
        view.backgroundColor = AppConstants.Colors.colorStandartInverted
        
        constraintSetup()

        loginButton.actionHandler = { [weak self] in
            guard let self = self else { return }
            self.loginButtonTap()
        }
    }
    //Настройка цветов кнопки, чтобы менялись в зависимсоти от состояния кнопки и темы приложения
    override func viewDidLayoutSubviews() {
        loginButton.setButtonColors()
    }
    
    //MARK: Функции для показа/скрытия клавиатуры
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
    
    //MARK: Настройка якорей
    func constraintSetup() {
        
        view.addSubview(loginScrollView)
        loginScrollView.addSubview(contentView)
        contentView.addSubview(getNewsLogoImageView)
        contentView.addSubview(authStackView)
        contentView.addSubview(loginButton)
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
        authStackView.widthAnchor.constraint(equalToConstant: AppConstants.ConstraintConstants.elementStandartSizes.width),
        authStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
        //Проверяем какой тип биометри, от этого вставляем картинку и размеры. Если биометрии нет - картинки не будет, и кнопка логина растянется до конца
        switch localAuthService.checkBiometryType() {
        case .face:
            authButtonSetup(image: UIImage(named: AppConstants.Asssets.faceID), height: AppConstants.ConstraintConstants.faceIDSizes.height, width: AppConstants.ConstraintConstants.faceIDSizes.width)
        case .touch:
            authButtonSetup(image: UIImage(named: AppConstants.Asssets.touchID), height: AppConstants.ConstraintConstants.touchIDSizes.height, width: AppConstants.ConstraintConstants.touchIDSizes.width)
        default:
            loginButtonConstaintSetup()
            loginButton.trailingAnchor.constraint(equalTo: authStackView.trailingAnchor).isActive = true
        }
    }
    //Настройка якорей кнопки Логина (которые не зависят от наличия биометрии)
    func loginButtonConstaintSetup() {
        NSLayoutConstraint.activate([
        loginButton.topAnchor.constraint(equalTo: authStackView.bottomAnchor, constant: AppConstants.UIElements.spacingBetweenElements),
        loginButton.heightAnchor.constraint(equalToConstant: AppConstants.ConstraintConstants.elementStandartSizes.height),
        loginButton.leadingAnchor.constraint(equalTo: authStackView.leadingAnchor),
        loginButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    //Настройка якорей биометрии
    func authButtonSetup(image: UIImage?, height: CGFloat, width: CGFloat) {
        contentView.addSubview(authTypeButton)
        
        guard let img = image else {return}
        authTypeButton.setBackgroundImage(img.withTintColor(AppConstants.Colors.purpleColorNormal), for: .normal)
        authTypeButton.setBackgroundImage(img.withTintColor(AppConstants.Colors.purpleColorSelected), for: .selected)
        
        loginButtonConstaintSetup()
        loginButton.trailingAnchor.constraint(equalTo: authTypeButton.leadingAnchor, constant: -AppConstants.UIElements.spacingBetweenElements).isActive = true
        
        authTypeButton.centerYAnchor.constraint(equalTo: loginButton.centerYAnchor).isActive = true
        authTypeButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        authTypeButton.heightAnchor.constraint(equalToConstant: height).isActive = true
        authTypeButton.trailingAnchor.constraint(equalTo: authStackView.trailingAnchor).isActive = true
    }
}

//MARK: Расширения для активации кнопки Log In
extension LogInViewController: UITextFieldDelegate {
    
    //Функция проверят заполненность текстовых полей из от этого активирует кнопку или нет
    func checkLoginButtonEnable() {
        guard let login = loginTextField.text else {return}
        guard let pass = passwordTextField.text else {return}
        
        if !login.isEmpty && !pass.isEmpty {
            loginButton.isEnabled = true
        } else if login.isEmpty || pass.isEmpty {
            loginButton.isEnabled = false
        }
    }
    //Проверка на редактирование текста
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        checkLoginButtonEnable()
        return true
    }
    //Проверка на конец редактирования текста
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        checkLoginButtonEnable()
        return true
    }
}

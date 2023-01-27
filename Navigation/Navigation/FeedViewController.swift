//
//  FeedViewController.swift
//  Navigation
//
//  Created by Artur Skaliy on 18.08.2021.
//

import UIKit


class FeedViewController: UIViewController {
    
    let postFeed: PostFeed = .init(title: "Hello world".localized)
    
    let newStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()
    let button1: UIButton = {
        let btn1 = UIButton()
        btn1.setTitle("btn 1", for: .normal)
        btn1.backgroundColor = UIColor.red
        btn1.translatesAutoresizingMaskIntoConstraints = false
        btn1.addTarget(self, action: #selector(tap), for: .touchUpInside)
        return btn1
    }()

    let button2: UIButton = {
        let btn2 = UIButton()
        btn2.setTitle("btn 2", for: .normal)
        btn2.backgroundColor = UIColor.gray
        btn2.translatesAutoresizingMaskIntoConstraints = false
        btn2.addTarget(self, action: #selector(tap), for: .touchUpInside)
        return btn2
    }()
    
    //Задача 6.2: добавил элементы текстфилд, кнопку, лейбел
    let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " Password".localized
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let checkGuessButton: CustomButton = {
        let button = CustomButton(title: "Check".localized, titleColor: .black)
        button.backgroundColor = .systemGray2
        return button
    }()
    
    let checkLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        return label
    }()
    
    //Задание 6.2: Добавил свойство с классом модели и реализовал функцию кнопки с идентикативностью лейбла
    var model = FeedModel()
    
    func sendText() {
        checkGuessButton.actionHandler = { [self] in
            if let text = textField.text {
                if model.check(word: text) == true {
                    checkLabel.backgroundColor = .green
                }
                else {
                    checkLabel.backgroundColor = .red
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Feed".localized
        self.view.backgroundColor = .blue
        view.addSubview(newStackView)
        view.addSubview(textField)
        view.addSubview(checkGuessButton)
        view.addSubview(checkLabel)
        sendText()
        
    }

    @objc func tap() {
        let postVC = PostViewController()
        postVC.title = postFeed.title
        navigationController?.pushViewController(postVC, animated: true)
    }
    override func viewWillLayoutSubviews() {
        newStackView.addArrangedSubview(button1)
        newStackView.addArrangedSubview(button2)
        NSLayoutConstraint.activate([
            newStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            checkGuessButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16),
            checkGuessButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkLabel.topAnchor.constraint(equalTo: checkGuessButton.bottomAnchor, constant: 16),
            checkLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkLabel.widthAnchor.constraint(equalTo: checkGuessButton.widthAnchor),
            checkLabel.heightAnchor.constraint(equalTo: checkGuessButton.heightAnchor)
            
        ])
        
    }
}

//Задание 6.2: сделал модель с проверкой на секретное слово
class FeedModel {
    let secretWord = "Джокер"
    func check(word: String) -> Bool { word == secretWord }
}

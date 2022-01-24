//
//  FeedViewController.swift
//  Navigation
//
//  Created by Artur Skaliy on 18.08.2021.
//

import UIKit


class FeedViewController: UIViewController {

    let post: Post = .init(title: "Hello world")
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(newStackView)
        
    }

    @objc func tap() {
        let postVC = PostViewController()
//        postVC.title = post.title
        navigationController?.pushViewController(postVC, animated: true)
    }
    override func viewWillLayoutSubviews() {
        newStackView.addArrangedSubview(button1)
        newStackView.addArrangedSubview(button2)
        NSLayoutConstraint.activate([
            newStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
}

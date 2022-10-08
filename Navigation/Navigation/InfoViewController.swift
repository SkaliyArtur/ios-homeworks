//
//  InfoViewController.swift
//  Navigation
//
//  Created by Artur Skaliy on 18.08.2021.
//

import UIKit

class InfoViewController: UIViewController {
    
    let alertButton: UIButton = {
        let button = UIButton()
        button.setTitle("AlertButton", for: .normal)
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let jsonLabel1: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let jsonLabel2: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .darkGray
        setupConstraints()
        dataTaskJSONSerialization()
        dataTaskJSONDecoder()
    }
    
    func setupConstraints() {
        view.addSubview(alertButton)
        view.addSubview(jsonLabel1)
        view.addSubview(jsonLabel2)
        NSLayoutConstraint.activate([
            alertButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            alertButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            jsonLabel1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            jsonLabel1.topAnchor.constraint(equalTo: alertButton.bottomAnchor, constant: 16),
            jsonLabel1.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            jsonLabel2.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            jsonLabel2.topAnchor.constraint(equalTo: jsonLabel1.bottomAnchor, constant: 16),
            jsonLabel2.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc func tap() {
        let alertVC = UIAlertController(title: "Это Alert", message: "Так попросили сделать в домашке", preferredStyle: .actionSheet)
        let actionOne = UIAlertAction(title: "OK", style: .default, handler: {(UIAlertAction) in print("Is's OK")})
        let actionTwo = UIAlertAction(title: "Cancel", style: .default, handler: {(UIAlertAction) in print("Is's Cancel")})
        alertVC.addAction(actionOne)
        alertVC.addAction(actionTwo)
        self.present(alertVC, animated: true, completion: nil)
    }

    func dataTaskJSONSerialization() {
        let session = URLSession.shared
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos/\(Int.random(in: 1...200))") else {return}
        let task = session.dataTask(with: url) {data, _, error in
            guard let data = data else { return }
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String:Any] {
                    guard let title = json["title"] as? String else {return}
                    DispatchQueue.main.async {
                        self.jsonLabel1.text = title
                    }
                }
            } catch let error as NSError {
                    print("error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    func dataTaskJSONDecoder() {
        let session = URLSession.shared
        guard let url = URL(string: "https://swapi.dev/api/planets/1") else {return}
        let task = session.dataTask(with: url) {data, _, error in
            do {
                guard let data = data else { return }
                let model = try JSONDecoder().decode(JSONModel.self, from: data)
                DispatchQueue.main.async {
                    self.jsonLabel2.text = "Период обращение планеты \(model.name) = \(model.orbitalPeriod)"
                }
            } catch let error as NSError {
                    print("error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}

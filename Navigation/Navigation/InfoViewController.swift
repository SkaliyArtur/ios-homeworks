//
//  InfoViewController.swift
//  Navigation
//
//  Created by Artur Skaliy on 18.08.2021.
//

import UIKit

class InfoViewController: UIViewController {
    
    let jsonLabel = UILabel()
    let group = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .darkGray
        let alertButton = UIButton(frame: CGRect(x: 100, y: 200, width: 100, height: 30))
        alertButton.setTitle("Alert", for: .normal)
        alertButton.addTarget(self, action: #selector(tap), for: .touchUpInside)
        view.addSubview(alertButton)
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos/\(Int.random(in: 1...200))") else {return}
        dataTaskJSONSerialization(url)
        jsonLabel.frame = CGRect(x: 16, y: 500, width: 400, height: 30)
        jsonLabel.textColor = .white
        view.addSubview(jsonLabel)
    }
    @objc func tap() {
        let alertVC = UIAlertController(title: "Это Alert", message: "Так попросили сделать в домашке", preferredStyle: .actionSheet)
        let actionOne = UIAlertAction(title: "OK", style: .default, handler: {(UIAlertAction) in print("Is's OK")})
        let actionTwo = UIAlertAction(title: "Cancel", style: .default, handler: {(UIAlertAction) in print("Is's Cancel")})
        alertVC.addAction(actionOne)
        alertVC.addAction(actionTwo)
        self.present(alertVC, animated: true, completion: nil)
        
    }

    func dataTaskJSONSerialization(_ address: URL) {
        let session = URLSession.shared
        let task = session.dataTask(with: address) {data, _, error in
            guard let data = data else { return }
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String:Any] {
                    guard let title = json["title"] as? String else {return}
                    print("title \(title)")
                    DispatchQueue.main.async {
                        self.jsonLabel.text = title
                        print("JSONLABEL \(String(describing: self.jsonLabel.text))")
                    }
                }
            } catch let error as NSError {
                    print("error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}

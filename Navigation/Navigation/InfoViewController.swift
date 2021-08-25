//
//  InfoViewController.swift
//  Navigation
//
//  Created by Artur Skaliy on 18.08.2021.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .darkGray
        let alertButton = UIButton(frame: CGRect(x: 100, y: 200, width: 100, height: 30))
        alertButton.setTitle("Alert", for: .normal)
        alertButton.addTarget(self, action: #selector(tap), for: .touchUpInside)
        view.addSubview(alertButton)
    }
    @objc func tap() {
        let alertVC = UIAlertController(title: "Это Alert", message: "Так попросили сделать в домашке", preferredStyle: .actionSheet)
        let actionOne = UIAlertAction(title: "OK", style: .default, handler: {(UIAlertAction) in print("Is's OK")})
        let actionTwo = UIAlertAction(title: "Cancel", style: .default, handler: {(UIAlertAction) in print("Is's Cancel")})
        alertVC.addAction(actionOne)
        alertVC.addAction(actionTwo)
        self.present(alertVC, animated: true, completion: nil)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

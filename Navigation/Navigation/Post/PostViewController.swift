//
//  PostViewController.swift
//  Navigation
//
//  Created by Artur Skaliy on 18.08.2021.
//

import UIKit


class PostViewController: UIViewController, UITableViewDelegate, UINavigationControllerDelegate {

    let tableView = UITableView.init(frame: .zero, style: .grouped)
    let coreDataService = CoreDataService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        navigationController?.delegate = self
        setupTableView()
        self.title = "Saved Posts"
        self.view.backgroundColor = .green
        tableView.backgroundColor = .green
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tap))
    }
    
    func setupTableView() {
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @objc func tap() {
        let infoVC = InfoViewController()
        self.present(infoVC, animated: true, completion: nil)
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        tableView.reloadData()
    }
    
}

extension PostViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        coreDataService.getContext().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
        cell.post = coreDataService.getContext()[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Delete") { (action, view, success) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
            cell.post = self.coreDataService.getContext()[indexPath.row]
            print(cell.post)
            self.coreDataService.deleteContext(profilePostModel: cell.post!)
            tableView.reloadData()
            success(true)
        }
        action.backgroundColor = .red
        action.image = UIImage(systemName: "trash")
        
        return UISwipeActionsConfiguration(actions: [action])
    }


}

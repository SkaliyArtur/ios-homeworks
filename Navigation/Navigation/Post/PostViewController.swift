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
    var savedPosts: [ProfilePostModel] = []
    var isSorted = false
    var filteredAuthor: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        navigationController?.delegate = self
        setupTableView()
        self.title = "Saved Posts"
        self.view.backgroundColor = .green
        tableView.backgroundColor = .green
        let authorFilterBtn = UIBarButtonItem(image: UIImage(systemName: "eye"), style: .plain, target: self, action: #selector(authorSearch))
        let clearFilterBtn = UIBarButtonItem(image: UIImage(systemName: "eye.slash"), style: .plain, target: self, action: #selector(clearFilter))
        navigationItem.leftBarButtonItems = [authorFilterBtn, clearFilterBtn]
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tap))
    }
    
    func returnPosts() -> [ProfilePostModel] {
        if isSorted == false {
            savedPosts = coreDataService.getContext()
        } else {
            savedPosts = coreDataService.getContextByAuthor(author: filteredAuthor!)
        }
        return savedPosts
    }
    
    @objc func authorSearch() {
        let alert = UIAlertController(title: "Поиск по автору", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Имя автора"
        }
        alert.addAction(UIAlertAction(title: "Отменить", style: .cancel))
        alert.addAction(UIAlertAction(title: "Применить", style: .default, handler: { [self] _ in
            guard let textField = alert.textFields?[0].text else {return}
            filteredAuthor = textField
            isSorted = true
            tableView.reloadData()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    @objc func clearFilter() {
        isSorted = false
        filteredAuthor = nil
        tableView.reloadData()
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
        returnPosts().count
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
        cell.post = returnPosts()[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Delete") { (action, view, success) in
            self.coreDataService.deleteContext(profilePostModel: self.returnPosts()[indexPath.row])
            tableView.reloadData()
//            self.tableView.deleteRows(at: [indexPath], with: .none)
            success(true)
        }
        action.backgroundColor = .red
        action.image = UIImage(systemName: "trash")
        return UISwipeActionsConfiguration(actions: [action])
    }
}

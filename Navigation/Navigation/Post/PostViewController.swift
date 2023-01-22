//
//  PostViewController.swift
//  Navigation
//
//  Created by Artur Skaliy on 18.08.2021.
//

import UIKit
import CoreData


class PostViewController: UIViewController, UITableViewDelegate, NSFetchedResultsControllerDelegate, UINavigationControllerDelegate {

    let tableView = UITableView.init(frame: .zero, style: .grouped)
    let coreDataService = CoreDataService()
    var savedPosts: [ProfilePostModel] = []
    var isSorted = false
    var filteredAuthor: String? = nil
    
    let fetchResultController: NSFetchedResultsController<PostEntity> = {
        let fetchRequest: NSFetchRequest<PostEntity> = PostEntity.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "author", ascending: false)]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataService.coreManager.context, sectionNameKeyPath: nil, cacheName: nil)
        return frc
    }()
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        
        navigationController?.delegate = self
        fetchResultController.delegate = self
        try? fetchResultController.performFetch()
        setupTableView()
        self.title = "Posts".localized
        self.view.backgroundColor = .green
        tableView.backgroundColor = .green
        let authorFilterBtn = UIBarButtonItem(image: UIImage(systemName: "eye"), style: .plain, target: self, action: #selector(authorSearch))
        let clearFilterBtn = UIBarButtonItem(image: UIImage(systemName: "eye.slash"), style: .plain, target: self, action: #selector(clearFilter))
        navigationItem.leftBarButtonItems = [authorFilterBtn, clearFilterBtn]
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tap))
    }
    
//    func returnPosts() -> [ProfilePostModel] {
//        if isSorted == false {
//            savedPosts = coreDataService.getContext()
//        } else {
//            savedPosts = coreDataService.getContextByAuthor(author: filteredAuthor!)
//        }
//        return savedPosts
//    }
    
    @objc func authorSearch() {
        let alert = UIAlertController(title: "Search by author".localized, message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Author name".localized
        }
        alert.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel))
        alert.addAction(UIAlertAction(title: "Apply".localized, style: .default, handler: { [self] _ in
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
        tableView.reloadData()
//        let infoVC = InfoViewController()
//        self.present(infoVC, animated: true, completion: nil)
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        try? fetchResultController.performFetch()
        tableView.reloadData()
    }
    
}

extension PostViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        returnPosts().count
        return fetchResultController.sections?[section].numberOfObjects ?? 0
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
//        cell.post = returnPosts()[indexPath.row]
        let post = fetchResultController.object(at: indexPath)
        cell.authorLablel.text = post.author
        cell.descriptionLablel.text = post.postDescription
        cell.imageImageView.image = UIImage(named: post.image ?? "logo.png")
        cell.likesLablel.text = "Likes: \(post.likes)"
        cell.viewsLablel.text = "Views: \(post.views)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Delete".localized) { (action, view, success) in
//            self.coreDataService.deleteContext(profilePostModel: self.returnPosts()[indexPath.row])
//            tableView.reloadData()
//            self.tableView.deleteRows(at: [indexPath], with: .none)
            let post = self.fetchResultController.object(at: indexPath)
            CoreDataService.coreManager.context.delete(post)
            try? CoreDataService.coreManager.context.save()
            success(true)
        }
        action.backgroundColor = .red
        action.image = UIImage(systemName: "trash")
        return UISwipeActionsConfiguration(actions: [action])
    }
}

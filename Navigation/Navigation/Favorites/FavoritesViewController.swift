//
//  PostViewController.swift
//  Navigation
//
//  Created by Artur Skaliy on 18.08.2021.
//

import UIKit
import CoreData


class FavoritesViewController: UIViewController, UITableViewDelegate, NSFetchedResultsControllerDelegate, UINavigationControllerDelegate {

    let favoritesFeedsTableView = UITableView.init(frame: .zero, style: .grouped)
    let coreDataService = CoreDataService()
    var favoritesFeeds: [FeedsModel] = []
    
    let fetchResultController: NSFetchedResultsController<FeedEntity> = {
        let fetchRequest: NSFetchRequest<FeedEntity> = FeedEntity.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "feedsDate", ascending: false)]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataService.coreManager.context, sectionNameKeyPath: nil, cacheName: nil)
        return frc
    }()
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        favoritesFeedsTableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(favoritesFeedsTableView)
        
        navigationController?.delegate = self
        fetchResultController.delegate = self
        try? fetchResultController.performFetch()
        setupTableView()
        
        self.view.backgroundColor = AppConstants.Colors.colorStandartInverted
        favoritesFeedsTableView.backgroundColor = AppConstants.Colors.colorStandartInverted
        favoritesFeedsTableView.contentInset = AppConstants.UIElements.tableViewEdges
    }
    

    func setupTableView() {
        favoritesFeedsTableView.register(FeedsTableViewCell.self, forCellReuseIdentifier: "FeedsTableViewCell")
        favoritesFeedsTableView.translatesAutoresizingMaskIntoConstraints = false
        favoritesFeedsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        favoritesFeedsTableView.widthAnchor.constraint(equalToConstant: AppConstants.ConstraintConstants.elementStandartSizes.width).isActive = true
        favoritesFeedsTableView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        favoritesFeedsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        favoritesFeedsTableView.dataSource = self
        favoritesFeedsTableView.delegate = self
    }
    
    @objc func tap() {
        favoritesFeedsTableView.reloadData()
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        try? fetchResultController.performFetch()
        favoritesFeedsTableView.reloadData()
    }
    
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchResultController.sections?[section].numberOfObjects ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedsTableViewCell", for: indexPath) as! FeedsTableViewCell
        cell.feed = coreDataService.getContext()[indexPath.row]
        let feed = fetchResultController.object(at: indexPath)
        cell.feedsTitleLabel.text = feed.feedsTitle
        cell.feedsTextLabel.text = feed.feedsText
        cell.feedsImageView.load(urlString: feed.feedsImage ?? "getNewsLogo")
        cell.feedsDateLabel.text = feed.feedsDate
        
        if coreDataService.checkFeedExists(feedModel: cell.feed!) == true {
            cell.favoritesButton.setBackgroundImage(UIImage(named: AppConstants.Asssets.favoritesFill)?.withTintColor(AppConstants.Colors.purpleColorNormal), for: .normal)
            cell.favoritesButton.setBackgroundImage(UIImage(named: AppConstants.Asssets.favoritesFill)?.withTintColor(AppConstants.Colors.purpleColorSelected), for: .selected)
        } else {
            cell.favoritesButton.setBackgroundImage(UIImage(named: AppConstants.Asssets.favorites)?.withTintColor(AppConstants.Colors.purpleColorNormal), for: .normal)
            cell.favoritesButton.setBackgroundImage(UIImage(named: AppConstants.Asssets.favorites)?.withTintColor(AppConstants.Colors.purpleColorSelected), for: .selected)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let feed = fetchResultController.object(at: indexPath)
        let profileVC = FeedViewController()
        profileVC.feedsTitleLabel.text = feed.feedsTitle
        profileVC.feedsTextLabel.text = feed.feedsText
        profileVC.feedsImageView.load(urlString: feed.feedsImage ?? "getNewsLogo")
        profileVC.feedsDateLabel.text = feed.feedsDate
        profileVC.modalPresentationStyle = .pageSheet
        self.present(profileVC, animated: true, completion: nil)
        }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Delete".localized) { (action, view, success) in
            let feed = self.fetchResultController.object(at: indexPath)
            CoreDataService.coreManager.context.delete(feed)
            try? CoreDataService.coreManager.context.save()
            success(true)
        }
        action.backgroundColor = .red
        action.image = UIImage(systemName: "trash")
        return UISwipeActionsConfiguration(actions: [action])
    }
}

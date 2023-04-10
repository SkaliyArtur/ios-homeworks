//
//  FeedsViewController.swift
//  Navigation
//
//  Created by Artur Skaliy on 18.08.2021.
//

import UIKit

class FeedsViewController: UIViewController {

    
    
    
    
    let searchStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = AppConstants.UIElements.spacingBetweenElements
        stackView.distribution = .fill
        stackView.clipsToBounds = true
        return stackView
    }()
    
    let searchForFeedsTextField = CustomTextField(placeHolder: AppConstants.UIElements.searchForFeedPlaceHolder)
    
    let getNewsButton = CustomButton(
            title: AppConstants.UIElements.searchForFeedText,
            titleColorEnable: AppConstants.Colors.colorStandartInverted,
            titleColorDisable: AppConstants.Colors.darkPurpleSecondaryColorNormal)
    
    let feedsTableView = UITableView.init(frame: .zero, style: .grouped)
    
    
    
    var feeds: [FeedsModel] = []
    
    let coreDataService = CoreDataService()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        getNewsButton.setButtonColors()
    }
    
    func setupView() {
        view.backgroundColor = AppConstants.Colors.colorStandartInverted
        
        view.addSubview(searchStackView)
        searchStackView.addArrangedSubview(searchForFeedsTextField)
        searchStackView.addArrangedSubview(getNewsButton)
        
        getNewsButton.actionHandler = { [weak self] in
            guard let self = self else { return }
            self.tap()
        }
        
        view.addSubview(feedsTableView)
        feedsTableView.translatesAutoresizingMaskIntoConstraints = false
        feedsTableView.dataSource = self
        feedsTableView.delegate = self
        feedsTableView.contentInset = AppConstants.UIElements.tableViewEdges
        feedsTableView.backgroundColor = AppConstants.Colors.colorStandartInverted
        feedsTableView.register(FeedsTableViewCell.self, forCellReuseIdentifier: "FeedsTableViewCell")
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            searchStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            searchStackView.heightAnchor.constraint(equalToConstant: 40),
            searchStackView.widthAnchor.constraint(equalToConstant: AppConstants.ConstraintConstants.elementStandartWidth),
            
            getNewsButton.widthAnchor.constraint(equalToConstant: 49),
            
            feedsTableView.topAnchor.constraint(equalTo: searchStackView.bottomAnchor),
            feedsTableView.leadingAnchor.constraint(equalTo: searchStackView.leadingAnchor),
            feedsTableView.trailingAnchor.constraint(equalTo: searchStackView.trailingAnchor),
            feedsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            
        ])
    }
    
    func tap() {
        dataTaskNewsJSONDecoder()
        print("Button TAPPED")
    }
    
    func dataTaskNewsJSONDecoder() {
        let session = URLSession.shared
        let group = DispatchGroup()
        guard let url = URL(string: "https://api.worldnewsapi.com/search-news?api-key=cef09b93847f45e1b39d668fe205bdd6&text=Crypto") else {return}
        group.enter()
            let task = session.dataTask(with: url) {data, _, error in
                do {
                    guard let data = data else { return }
                    let model = try JSONDecoder().decode(FeedsJSONModel.self, from: data)
                    for news in model.news {
                        print("JSON: \(news.publishDate)")
                        self.feeds.append(.init(
                                        feedsTitle: news.title,
                                        feedsText: news.text,
                                        feedsImage: news.image ?? "getNewsLogo",
                                        feedsDate: news.publishDate))
       
                    }
                    
                    group.leave()
                } catch let error as NSError {
                        print("error: \(error.localizedDescription) OR \(error)")
                }
            }
            task.resume()
        group.notify(queue: .main) {
            self.feedsTableView.reloadData()
        }
    }
    
    @objc func tapFavoritesButton(_ sender: UITapGestureRecognizer) {
            guard let indexPath = feedsTableView.indexPathForRow(at: sender.location(in: self.feedsTableView)) else {return}
            let cell = feedsTableView.dequeueReusableCell(withIdentifier: "FeedsTableViewCell", for: indexPath) as! FeedsTableViewCell
            cell.feed = feeds[indexPath.row]
//            try? CoreDataService.coreManager.persistentContainer.viewContext.save()
            coreDataService.saveContext(feedModel: .init(feedsTitle: feeds[indexPath.row].feedsTitle, feedsText: feeds[indexPath.row].feedsText, feedsImage: feeds[indexPath.row].feedsImage, feedsDate: feeds[indexPath.row].feedsDate))
        self.feedsTableView.reloadData()
    }
}

extension FeedsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return feeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedsTableViewCell", for: indexPath) as! FeedsTableViewCell
        cell.feed = feeds[indexPath.row]
        cell.layer.shadowColor = AppConstants.Colors.purpleSecondaryColorNormal.cgColor
          cell.layer.shadowOffset = CGSize(width: 0, height: 1)
          cell.layer.shadowOpacity = 1
          cell.layer.shadowRadius = 0
          cell.layer.masksToBounds = false
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapFavoritesButton(_:)))
        cell.favoritesButton.addGestureRecognizer(tapGestureRecognizer)
        
        if coreDataService.checkFeedExists(feedModel: cell.feed!) == true {
            cell.favoritesButton.setBackgroundImage(UIImage(named: AppConstants.Asssets.favoritesFill)?.withTintColor(AppConstants.Colors.purpleColorNormal), for: .normal)
            cell.favoritesButton.setBackgroundImage(UIImage(named: AppConstants.Asssets.favoritesFill)?.withTintColor(AppConstants.Colors.purpleColorSelected), for: .selected)
        } else {
            cell.favoritesButton.setBackgroundImage(UIImage(named: AppConstants.Asssets.favorites)?.withTintColor(AppConstants.Colors.purpleColorNormal), for: .normal)
            cell.favoritesButton.setBackgroundImage(UIImage(named: AppConstants.Asssets.favorites)?.withTintColor(AppConstants.Colors.purpleColorSelected), for: .selected)
        }
        
        return cell
    }
    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedsTableViewCell", for: indexPath as IndexPath)
//            return cell
//        }
////
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! FeedsTableViewCell
//        let profileVC = FeedViewController(
//            feedsTitleLabel: cell.feedsTitleLabel,
//            feedsTextLabel: cell.feedsTextLabel,
//            feedsImageView: cell.feedsImageView,
//            feedsDateLabel: cell.feedsDateLabel,
//            favoritesButton: cell.favoritesButton)
//        self.navigationController?.pushViewController(profileVC, animated: true)
//        print("SELECTED!!")
//        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////        let cell = tableView.cellForRow(at: indexPath) as! FeedsTableViewCell
//        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedsTableViewCell", for: indexPath) as! FeedsTableViewCell
        let profileVC = FeedViewController()
        profileVC.feedsTitleLabel.text = feeds[indexPath.row].feedsTitle
        profileVC.feedsTextLabel.text = feeds[indexPath.row].feedsText
        profileVC.feedsImageView.load(urlString: feeds[indexPath.row].feedsImage)
        profileVC.feedsDateLabel.text = feeds[indexPath.row].feedsDate
        profileVC.modalPresentationStyle = .pageSheet
        self.present(profileVC, animated: true, completion: nil)
        }
}

extension FeedsViewController: UITableViewDelegate {
    
}

extension FeedsViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        feedsTableView.reloadData()
    }
}

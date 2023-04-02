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
    let coreDataService = CoreDataService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            searchStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            searchStackView.heightAnchor.constraint(equalToConstant: 40),
            searchStackView.widthAnchor.constraint(equalToConstant: AppConstants.ConstraintConstants.loginAuthStackViewWidth),
            getNewsButton.widthAnchor.constraint(equalToConstant: 49)
        ])
    }
    
    
    
    
    func tap() {
        dataTaskNewsJSONDecoder()
        print("Button TAPPED")
    }
    
    func dataTaskNewsJSONDecoder() {
        let session = URLSession.shared
        let group = DispatchGroup()
        guard let url = URL(string: "https://api.worldnewsapi.com/search-news?api-key=cef09b93847f45e1b39d668fe205bdd6&text=batman") else {return}
        group.enter()
            let task = session.dataTask(with: url) {data, _, error in
                do {
                    guard let data = data else { return }
                    let model = try JSONDecoder().decode(NewsJSONModel.self, from: data)
                    for news in model.news {
//                        self.profileViewModel.postsData.append(.init(author: news.author ?? "no author", postDescription: news.title, image: news.image, likes: news.id, views: 0))
                    }
                    group.leave()
                } catch let error as NSError {
                        print("error: \(error.localizedDescription) OR \(error)")
                }
            }
            task.resume()
        group.notify(queue: .main) {
//            self.tableView.reloadData()
        }
    }
    
//    @objc func addPost(_ sender: UITapGestureRecognizer) {
//        guard let indexPath = tableView.indexPathForRow(at: sender.location(in: self.tableView)) else {return}
//        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
////        cell.post = profileViewModel.postsData[indexPath.row]
////        CoreDataService.coreManager.persistentContainer.viewContext.save()
////        coreDataService.saveContext(
////            postModel: .init(
////                author: profileViewModel.postsData[indexPath.row].author,
////                postDescription: profileViewModel.postsData[indexPath.row].postDescription,
////                image: profileViewModel.postsData[indexPath.row].image,
////                likes: profileViewModel.postsData[indexPath.row].likes,
////                views: profileViewModel.postsData[indexPath.row].views)
////        )
//    }

    
}

extension FeedsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
        return cell
    }
}

extension FeedsViewController: UITableViewDelegate {
    
}

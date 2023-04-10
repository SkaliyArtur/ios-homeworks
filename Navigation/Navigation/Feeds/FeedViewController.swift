//
//  FeedViewController.swift
//  Navigation
//
//  Created by Artur Skaliy on 10.04.2023.
//

import Foundation
import UIKit

class FeedViewController: UIViewController {

//    var feedsTitleLabel: UILabel
//    var feedsTextLabel: UILabel
//    var feedsImageView: UIImageView
//    var feedsDateLabel: UILabel
//    var favoritesButton: UIButton
//
//    init(feedsTitleLabel: UILabel, feedsTextLabel: UILabel, feedsImageView: UIImageView, feedsDateLabel: UILabel, favoritesButton: UIButton) {
//        self.feedsTitleLabel = feedsTitleLabel
//        self.feedsTextLabel = feedsTextLabel
//        self.feedsImageView = feedsImageView
//        self.feedsDateLabel = feedsDateLabel
//        self.favoritesButton = favoritesButton
//        super.init(nibName: nil, bundle: nil)
//       }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    let feedScrollView: UIScrollView = {
    let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = AppConstants.Colors.colorStandartInverted
        return scrollView
    }()
    
    let contentView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let feedsTitleLabel = CustomUILabel(font: AppConstants.UIElements.feedsTitleSemiBold!, lines: AppConstants.UIElements.feedsZeroNumberLines)
    
    let feedsTextLabel = CustomUILabel(font: AppConstants.UIElements.feedsTextRegular!, lines: AppConstants.UIElements.feedsZeroNumberLines)
    
    let feedsImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.backgroundColor = AppConstants.Colors.colorStandart
        image.layer.cornerRadius = AppConstants.UIElements.cornerRadius
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let feedsDateLabel = CustomUILabel(font: AppConstants.UIElements.feedsDateCountryRegular!, lines: AppConstants.UIElements.feedsZeroNumberLines)
    
    let favoritesButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    
    func setupView() {
        view.backgroundColor = AppConstants.Colors.colorStandartInverted
        
        view.addSubview(feedScrollView)
        feedScrollView.addSubview(contentView)
        
        contentView.addSubview(feedsTitleLabel)
        contentView.addSubview(feedsTextLabel)
        contentView.addSubview(feedsImageView)
        contentView.addSubview(feedsDateLabel)
        contentView.addSubview(favoritesButton)
        
        feedsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        feedsTextLabel.translatesAutoresizingMaskIntoConstraints = false
        feedsImageView.translatesAutoresizingMaskIntoConstraints = false
        feedsDateLabel.translatesAutoresizingMaskIntoConstraints = false
        favoritesButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            feedScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            feedScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            feedScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            feedScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: feedScrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: feedScrollView.bottomAnchor),
            contentView.centerXAnchor.constraint(equalTo: feedScrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalToConstant: AppConstants.ConstraintConstants.elementStandartSizes.width),
            
            feedsTitleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: AppConstants.UIElements.tableCellTop),
            feedsTitleLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            feedsTitleLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            
            feedsImageView.topAnchor.constraint(equalTo: feedsTitleLabel.bottomAnchor, constant: AppConstants.UIElements.spacingBetweenElements),
            feedsImageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            feedsImageView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
//            feedsImageView.widthAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.widthAnchor),
            feedsImageView.heightAnchor.constraint(equalTo: feedsImageView.widthAnchor),
            
            feedsTextLabel.topAnchor.constraint(equalTo: feedsImageView.bottomAnchor, constant: AppConstants.UIElements.spacingBetweenElements),
            feedsTextLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            feedsTextLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            
            feedsDateLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            feedsDateLabel.topAnchor.constraint(equalTo: feedsTextLabel.bottomAnchor, constant: AppConstants.UIElements.spacingBetweenElements),
            feedsDateLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: AppConstants.UIElements.tableCellBottom),
            
            favoritesButton.centerYAnchor.constraint(equalTo: feedsDateLabel.centerYAnchor),
            favoritesButton.widthAnchor.constraint(equalToConstant: AppConstants.ConstraintConstants.favoritesSizes.width),
            favoritesButton.heightAnchor.constraint(equalToConstant: AppConstants.ConstraintConstants.favoritesSizes.height),
            favoritesButton.trailingAnchor.constraint(equalTo: feedsImageView.trailingAnchor)
        ])
    }
    
}

//
//  FeedsTableViewCell.swift
//  Navigation
//
//  Created by Artur Skaliy on 23.01.2022.
//

import UIKit
//import StorageService

class FeedsTableViewCell: UITableViewCell {
    
    var feed: FeedsModel? {
        didSet {
            feedsTitleLabel.text = feed?.feedsTitle
            feedsTextLabel.text = feed?.feedsText
            feedsImageView.load(urlString: feed?.feedsImage ?? "getNewsLogo")
            feedsDateLabel.text = feed?.feedsDate
        }
    }
    
    let feedsTitleLabel = CustomUILabel(font: AppConstants.UIElements.feedsTitleSemiBold!, lines: AppConstants.UIElements.feedsZeroNumberLines)
    
    let feedsTextLabel = CustomUILabel(font: AppConstants.UIElements.feedsTextRegular!, lines: AppConstants.UIElements.feedsTextNumberLines)
    
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


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setupFeedsTableViewCell()
        
        
    }
    
    func setupFeedsTableViewCell() {
        contentView.backgroundColor = AppConstants.Colors.colorStandartInverted
        contentView.addSubview(feedsTitleLabel)
        contentView.addSubview(feedsTextLabel)
        contentView.addSubview(feedsImageView)
        contentView.addSubview(feedsDateLabel)
        contentView.addSubview(favoritesButton)
        
        
        
        feedsTitleLabel.setContentHuggingPriority(.required, for: .vertical)
        feedsTextLabel.setContentHuggingPriority(.required, for: .vertical)
        feedsDateLabel.setContentHuggingPriority(.required, for: .vertical)
        
        NSLayoutConstraint.activate([
            feedsTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: AppConstants.UIElements.tableCellTop),
            feedsTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            feedsTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            feedsImageView.topAnchor.constraint(equalTo: feedsTitleLabel.bottomAnchor, constant: AppConstants.UIElements.spacingBetweenElements),
            feedsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            feedsImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            feedsImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            feedsImageView.heightAnchor.constraint(equalTo: feedsImageView.widthAnchor),
            
            feedsTextLabel.topAnchor.constraint(equalTo: feedsImageView.bottomAnchor, constant: AppConstants.UIElements.spacingBetweenElements),
            feedsTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            feedsTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            feedsDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            feedsDateLabel.topAnchor.constraint(equalTo: feedsTextLabel.bottomAnchor, constant: AppConstants.UIElements.spacingBetweenElements),
            feedsDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: AppConstants.UIElements.tableCellBottom),
            
            favoritesButton.centerYAnchor.constraint(equalTo: feedsDateLabel.centerYAnchor),
            favoritesButton.widthAnchor.constraint(equalToConstant: AppConstants.ConstraintConstants.favoritesSizes.width),
            favoritesButton.heightAnchor.constraint(equalToConstant: AppConstants.ConstraintConstants.favoritesSizes.height),
            favoritesButton.trailingAnchor.constraint(equalTo: feedsImageView.trailingAnchor)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    

}



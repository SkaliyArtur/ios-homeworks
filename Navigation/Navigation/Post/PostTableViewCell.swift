//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Artur Skaliy on 23.01.2022.
//

import UIKit
//import StorageService

class PostTableViewCell: UITableViewCell {

    
 //Вариант применения значений ячейки через didSet
    
    var post: ProfilePostModel? {
        didSet {
            authorLablel.text = post?.author
            descriptionLablel.text = post?.description
            imageImageView.image = UIImage(named: post?.image ?? "logo.png")
            likesLablel.text = "Likes: \(post?.likes ?? 0)"
            viewsLablel.text = "Views: \(post?.views ?? 0)"

        }
    }
    
    let authorLablel: UILabel = {
        var authLabel = UILabel()
        authLabel.textColor = .black
        authLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        authLabel.numberOfLines = 2
        authLabel.translatesAutoresizingMaskIntoConstraints = false
        return authLabel
    }()
    
    let descriptionLablel: UILabel = {
        var descLabel = UILabel()
        descLabel.textColor = .systemGray
        descLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        descLabel.numberOfLines = 0
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        return descLabel
    }()
    
    let imageImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let likesLablel: UILabel = {
        var likeLabel = UILabel()
        likeLabel.textColor = .black
        likeLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        likeLabel.translatesAutoresizingMaskIntoConstraints = false
        return likeLabel
    }()
    
    let viewsLablel: UILabel = {
        var viewLabel = UILabel()
        viewLabel.textColor = .black
        viewLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        viewLabel.translatesAutoresizingMaskIntoConstraints = false
        return viewLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setupPostTableViewCell()
        
    }
    
    func setupPostTableViewCell() {
        contentView.addSubview(authorLablel)
        contentView.addSubview(descriptionLablel)
        contentView.addSubview(imageImageView)
        contentView.addSubview(likesLablel)
        contentView.addSubview(viewsLablel)
        
        authorLablel.setContentHuggingPriority(.required, for: .vertical)
        descriptionLablel.setContentHuggingPriority(.required, for: .vertical)
        likesLablel.setContentHuggingPriority(.required, for: .vertical)
        viewsLablel.setContentHuggingPriority(.required, for: .vertical)
        
        NSLayoutConstraint.activate([
            authorLablel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            authorLablel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            authorLablel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            
            imageImageView.topAnchor.constraint(equalTo: authorLablel.bottomAnchor, constant: 16),
            imageImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            imageImageView.heightAnchor.constraint(equalTo:  imageImageView.widthAnchor),
            
            descriptionLablel.topAnchor.constraint(equalTo: imageImageView.bottomAnchor, constant: 16),
            descriptionLablel.leadingAnchor.constraint(equalTo: authorLablel.leadingAnchor),
            descriptionLablel.trailingAnchor.constraint(equalTo: authorLablel.trailingAnchor),
            
            likesLablel.leftAnchor.constraint(equalTo: authorLablel.leftAnchor),
            likesLablel.topAnchor.constraint(equalTo: descriptionLablel.bottomAnchor, constant: 16),
            likesLablel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            viewsLablel.rightAnchor.constraint(equalTo: authorLablel.rightAnchor),
            viewsLablel.topAnchor.constraint(equalTo: descriptionLablel.bottomAnchor, constant: 16),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

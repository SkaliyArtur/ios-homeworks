//
////  PhotosCollectionViewCell.swift
////  Navigation
////
////  Created by Artur Skaliy on 16.03.2022.
////
//
//import UIKit
//
//class PhotosCollectionViewCell: UICollectionViewCell {
//    
//    
//    let imageImageView: UIImageView = {
//        let image = UIImageView()
//        image.translatesAutoresizingMaskIntoConstraints = false
//        return image
//    }()
//    
//    func setup() {
//        contentView.addSubview(imageImageView)
//        NSLayoutConstraint.activate([
//            imageImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            imageImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            imageImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            imageImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
//            
//        ])
//    }
//    
//    override init(frame: CGRect) {
//        super.init(frame: .zero)
//        setup()
//        
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//}

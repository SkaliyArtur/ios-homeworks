//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Artur Skaliy on 08.02.2022.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {

    
    let photosLabel: UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.text = "Photos".localized
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let arrowIcon: UIImageView = {
       let icon = UIImageView()
        icon.image = UIImage(systemName: "arrow.right")
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.tintColor = .black
        return icon
    }()
    
    let photoImageView1: UIImageView = {
        let image = UIImageView()
        image.image = CarsData.carsPhotos[0]
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 6
        image.clipsToBounds = true
        return image
    }()
    let photoImageView2: UIImageView = {
        let image = UIImageView()
        image.image = CarsData.carsPhotos[1]
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 6
        image.clipsToBounds = true
        return image
    }()
    let photoImageView3: UIImageView = {
        let image = UIImageView()
        image.image = CarsData.carsPhotos[2]
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 6
        image.clipsToBounds = true
        return image
    }()
    let photoImageView4: UIImageView = {
        let image = UIImageView()
        image.image = CarsData.carsPhotos[3]
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 6
        image.clipsToBounds = true
        return image
    }()
    
    let previewStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setupPhotosTableViewCell()
        
    }
    
    func setupPhotosTableViewCell() {
        contentView.addSubview(photosLabel)
        contentView.addSubview(previewStackView)
        contentView.addSubview(arrowIcon)
        
        previewStackView.addArrangedSubview(photoImageView1)
        previewStackView.addArrangedSubview(photoImageView2)
        previewStackView.addArrangedSubview(photoImageView3)
        previewStackView.addArrangedSubview(photoImageView4)
        
        photosLabel.setContentHuggingPriority(.required, for: .vertical)
        
        NSLayoutConstraint.activate([
            photosLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            photosLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            
            previewStackView.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: 12),
            previewStackView.leadingAnchor.constraint(equalTo: photosLabel.leadingAnchor),
            previewStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            previewStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            photoImageView1.widthAnchor.constraint(equalTo: previewStackView.heightAnchor),
            photoImageView2.widthAnchor.constraint(equalTo: previewStackView.heightAnchor),
            photoImageView3.widthAnchor.constraint(equalTo: previewStackView.heightAnchor),
            photoImageView4.widthAnchor.constraint(equalTo: previewStackView.heightAnchor),
            
            arrowIcon.centerYAnchor.constraint(equalTo: photosLabel.centerYAnchor),
            arrowIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            arrowIcon.heightAnchor.constraint(equalTo: photosLabel.heightAnchor),
            arrowIcon.widthAnchor.constraint(equalTo: arrowIcon.heightAnchor),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


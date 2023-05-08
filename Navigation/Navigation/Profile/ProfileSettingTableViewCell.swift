//
//  ProfileSettingTableViewCell..swift
//  Navigation
//
//  Created by Artur Skaliy on 08.02.2022.
//

import UIKit

class ProfileSettingTableViewCell: UITableViewCell {

    
    let settingLabel = CustomUILabel(font: AppConstants.UIElements.textFontRegular!, lines: AppConstants.UIElements.feedsZeroNumberLines)
    
    let arrowImageView: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "arrow")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let separatorLineImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIColor.createOnePixelImage(AppConstants.Colors.purpleSecondaryColorNormal)()
         image.translatesAutoresizingMaskIntoConstraints = false
         return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setupProfileSettingTableViewCell()
        
    }
    
    func setupProfileSettingTableViewCell() {
        contentView.addSubview(settingLabel)
        contentView.addSubview(arrowImageView)
        contentView.addSubview(separatorLineImageView)
        contentView.backgroundColor = AppConstants.Colors.colorStandartInverted
        
        settingLabel.setContentHuggingPriority(.required, for: .vertical)
        
        NSLayoutConstraint.activate([
            settingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            settingLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            arrowImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            separatorLineImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separatorLineImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            separatorLineImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separatorLineImageView.heightAnchor.constraint(equalToConstant: AppConstants.UIElements.tabBarLineHeight*2)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


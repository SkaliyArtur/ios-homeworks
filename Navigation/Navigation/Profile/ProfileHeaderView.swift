//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Artur Skaliy on 25.08.2021.
//

import UIKit

class ProfileHeaderView: UIView {
    
    let name = UILabel()
    let button = UIButton()
    let image = UIImageView()
    let text = UITextField()
    
    @objc func buttonPressed() {
        print(text.text!)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        name.text = "Mr. Crabs"
        name.textColor = .black
        name.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        name.textAlignment = NSTextAlignment.center
        self.addSubview(name)
        
        image.image = UIImage(named: "MrKrabs.png")
        self.addSubview(image)
        
       
        button.setTitle("Show status", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        self.addSubview(button)
        
        text.text = "Waiting for something..."
        text.textColor = .gray
        text.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        self.addSubview(text)
        
    }
    
    override func layoutSubviews() {
        name.bounds.size = name.intrinsicContentSize
        name.frame = CGRect(x: (self.frame.size.width - name.bounds.width)/2, y: safeAreaInsets.top + 27, width: name.bounds.width, height: name.bounds.height)
        
        
        image.frame = CGRect(x: safeAreaInsets.left + 16, y: safeAreaInsets.top + 16, width: 110, height: 110)
        image.layer.borderWidth = 3
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.cornerRadius = image.frame.size.width/2
        image.clipsToBounds = true
        
        button.frame = CGRect(x: safeAreaInsets.left + 16, y: image.frame.maxY + 16, width: self.frame.width - 32, height: 50)
        
        text.bounds.size = text.intrinsicContentSize
        text.frame = CGRect(x: name.frame.minX, y: button.frame.minY - 34, width: text.bounds.width, height: text.bounds.height)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        name.frame.origin = .init(x: 30, y: 27)
        name.text = "Mr. Crabs"
        name.textColor = .black
        name.font = name.font.withSize(18)
        self.addSubview(name)
        
       
        button.setTitle("Test", for: .normal)
//        button.frame = CGRect(x: self.frame.size.width / 2, y: 100, width: 50, height: 50)
        self.addSubview(button)
        
    }
    
    override func layoutSubviews() {
        button.frame = CGRect(x: self.frame.size.width/2 - 50/2, y: 100, width: 50, height: 50)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

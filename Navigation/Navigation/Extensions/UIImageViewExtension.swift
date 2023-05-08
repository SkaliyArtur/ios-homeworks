//
//  UIImageViewExtension.swift
//  Navigation
//
//  Created by Artur Skaliy on 03.04.2023.
//

import Foundation
import UIKit

var imageCache = NSCache<AnyObject, AnyObject>()
//Расширение для загрузки картинку по URL
extension UIImageView {
    
    func load(urlString: String) {
        
        if let image = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = image
            return
        }
        guard let url = URL(string: urlString) else {return}
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        imageCache.setObject(image, forKey: urlString as NSString)
                        self?.image = image
                    }
                }
            }
        }
    }
}

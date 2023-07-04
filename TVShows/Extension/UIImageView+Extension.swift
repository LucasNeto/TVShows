//
//  UIImageView+Extension.swift
//  TVShows
//
//  Created by Lucas  N Santana on 30/06/23.
//

import UIKit

extension UIImageView {
    func loadImageFrom(url: String?, completion: ((UIImage?) -> Void)? = nil){
        guard let imageUrl = url, let url = URL(string: imageUrl) else {
            completion?(nil)
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                completion?(nil)
                return
            }
            guard let data = data else {
                completion?(nil)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data)
                self.image = image
                completion?(image)
            })
        }).resume()
    }
}

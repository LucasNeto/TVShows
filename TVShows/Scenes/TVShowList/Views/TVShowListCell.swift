//
//  TVShowListCell.swift
//  TVShows
//
//  Created by Lucas  N Santana on 30/06/23.
//

import UIKit

class TVShowListCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func set(show: Show) {
        imageView?.image = nil
        nameLabel?.text = show.name
        activityIndicator?.startAnimating()
        imageView?.loadImageFrom(url: show.image?.medium) { [weak self] image in
            self?.activityIndicator?.stopAnimating()
            if image == nil {
                self?.imageView?.image = #imageLiteral(resourceName: "tv.png")
            }
        }
    }

}

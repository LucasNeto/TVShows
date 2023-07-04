//
//  TVShowDetailCell.swift
//  TVShows
//
//  Created by Lucas  N Santana on 03/07/23.
//

import UIKit

class TVShowDetailCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var accessoryImageView: UIImageView!
    @IBOutlet weak var expandedView: UIView!
    @IBOutlet weak var episodeImageView: UIImageView!
    @IBOutlet weak var episodeNumberLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var expandedViewConstraint: NSLayoutConstraint!
    
    var episode: EpisodeViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkIfItsExpanded()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel?.text = nil
        episodeImageView?.image = nil
        episodeNumberLabel?.text = nil
        summaryLabel?.text = nil
        expandedView?.isHidden = true
        expandedViewConstraint?.constant = 0
        accessoryImageView?.image = UIImage(systemName: "chevron.down")
    }
    
    func setup(with episode: EpisodeViewModel) {
        self.episode = episode
        nameLabel?.text = "\(episode.number): \(episode.name)"
        episodeImageView.loadImageFrom(url: episode.imageUrl)
        episodeNumberLabel.text = "Season: \(episode.season) / Episode: \(episode.number)"
        if let attributedHtmlString = episode.summary.attributedHtmlString {
            summaryLabel.attributedText = attributedHtmlString
        } else {
            summaryLabel.text = episode.summary
        }
        checkIfItsExpanded()
        
    }
    
    func checkIfItsExpanded() {
        if episode?.isExpanded ?? false {
            expand()
        } else {
            hideView()
        }
    }
    
    func expand() {
        UIView.animate(withDuration: 0.5) {
            self.expandedView.isHidden = false
            self.expandedViewConstraint.constant = 150
            self.accessoryImageView.image = UIImage(systemName: "chevron.up")
        }
    }
    
    func hideView() {
        UIView.animate(withDuration: 0.5) {
            self.expandedView.isHidden = true
            self.expandedViewConstraint.constant = 0
            self.accessoryImageView.image = UIImage(systemName: "chevron.down")
        }
    }
}

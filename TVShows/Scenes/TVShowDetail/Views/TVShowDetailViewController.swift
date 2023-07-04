//
//  TVShowDetailViewController.swift
//  TVShows
//
//  Created by Lucas  N Santana on 01/07/23.
//

import UIKit

class TVShowDetailViewController: BaseViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    var scrollViewContentHeight: CGFloat = 1500
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var episodesActivityIndicator: UIActivityIndicatorView!
    
    var interactor: TVShowDetailInteractor?
    var show: Show?
    
    var seasons: [SeasonViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTableView()
        interactor?.fetchShow()
    }

    private func setup() {
        guard let show = show else {
            fatalError("Show need be set before the setup.")
        }
        let viewController = self
        let presenter = TVShowDetailPresenter(viewController: viewController)
        let worker = TVShowDetailWorker()
        let interactor = TVShowDetailInteractor(show: show, presenter: presenter, worker: worker)
        viewController.interactor = interactor
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: "TVShowDetailCell",bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: "TVShowDetailCell")
        scrollView.contentSize = CGSizeMake(UIScreen.main.bounds.width, scrollViewContentHeight)
    }
    
    func displayDetail(viewModel: TVShowDetailViewModel) {
        self.title = viewModel.name
        posterImageView.loadImageFrom(url: viewModel.imageUrl)
        nameLabel.text = viewModel.name
        genreLabel.text = viewModel.genre
        daysLabel.text = viewModel.days
        if let attributedHtmlString = viewModel.summary.attributedHtmlString {
            summaryLabel.attributedText = attributedHtmlString
        } else {
            summaryLabel.text = viewModel.summary
        }
    }
    
    func showLoadingEpisodes() {
        episodesActivityIndicator.startAnimating()
    }
    func stopLoadingEpisodes() {
        episodesActivityIndicator.stopAnimating()
    }
    
    func displaySeasons(seasons: [SeasonViewModel]) {
        self.seasons = seasons
        self.tableView.reloadData()
    }
}

extension TVShowDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        seasons.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        seasons[section].episodes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TVShowDetailCell") as! TVShowDetailCell
        let season = seasons[indexPath.section]
        let episode = season.episodes[indexPath.row]
        cell.setup(with: episode)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(frame: view.frame)
        label.text = seasons[section].seasonTitle
        label.font = UIFont.boldSystemFont(ofSize: 19)
        label.backgroundColor = .white
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        seasons[indexPath.section].episodes[indexPath.row].isExpanded.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

//
//  TVShowDetailPresenter.swift
//  TVShows
//
//  Created by Lucas  N Santana on 01/07/23.
//
import Foundation

struct TVShowDetailPresenter {
    weak var viewController: TVShowDetailViewController?
    
    func presentShow(show: Show) {
        var showGenres = "-"
        var daysAndTime = ""
        if let genres = show.genres,
           !genres.isEmpty{
            showGenres = genres.joined(separator: ", ")
        }
        if let days = show.schedule?.days, !days.isEmpty {
            daysAndTime += "Days: \(days.joined(separator: ", "))"
        } else {
            daysAndTime += "Days: -"
        }
        if let time  = show.schedule?.time, !time.isEmpty {
            daysAndTime += " / Time: \(time)"
        } else {
            daysAndTime += " / Time: -"
        }
        let detailViewModel = TVShowDetailViewModel(
            imageUrl: show.image?.original,
            name: show.name ?? "-",
            summary: show.summary ?? "-",
            genre: "Genres: \(showGenres)",
            days: daysAndTime)
        viewController?.displayDetail(viewModel: detailViewModel)
    }
    
    func presentSeasons(seasons: [Season]) {
        let viewmodel: [SeasonViewModel] = seasons.compactMap { season in
            SeasonViewModel(
                seasonTitle: "Season \(season.season ?? 0)",
                episodes: season.episodes.map({ episode in
                    EpisodeViewModel(name: episode.name ?? "-",
                                     number: "\(episode.number ?? 0)",
                                     season: "\(season.season ?? 0)",
                                     summary: episode.summary ?? "-",
                                     imageUrl: episode.image?.medium,
                                     isExpanded: false)
                }))
        }
        
        DispatchQueue.main.async {
            viewController?.displaySeasons(seasons: viewmodel)
        }
    }
    
    func showLoadingEpisodes() {
        DispatchQueue.main.async {
            viewController?.showLoadingEpisodes()
        }
    }
    
    func stopLoadingEpisodes() {
        DispatchQueue.main.async {
            viewController?.stopLoadingEpisodes()
        }
    }
    
    func presentError(error: ServiceError) {
        let viewModel = AlertViewModel(title: "Error", message: error.getMessage(), buttonTitle: "OK")
        DispatchQueue.main.async {
            viewController?.displayAlert(viewModel: viewModel)
        }
    }
}

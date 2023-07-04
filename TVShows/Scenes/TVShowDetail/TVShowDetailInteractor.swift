//
//  TVShowDetailInteractor.swift
//  TVShows
//
//  Created by Lucas  N Santana on 01/07/23.
//

struct TVShowDetailInteractor {
    var show: Show
    var presenter: TVShowDetailPresenter
    var worker: TVShowDetailWorker
    
    func fetchShow() {
        presenter.presentShow(show: show)
        loadEpisodes()
    }
    
    func loadEpisodes() {
        presenter.showLoadingEpisodes()
        worker.loadEpisodes(by: show.id) { episodes, error in
            presenter.stopLoadingEpisodes()
            if let error = error {
                presenter.presentError(error: error)
            } else if let episodes = episodes {
                let dic = Dictionary(grouping: episodes, by: { $0.season })
                var seasons: [Season] = dic.map { Season(season: $0.key, episodes: $0.value) }
                seasons.sort(by: { $0.season ?? 0 < $1.season ?? 0 })
                presenter.presentSeasons(seasons: seasons)
            }
        }
    }
}

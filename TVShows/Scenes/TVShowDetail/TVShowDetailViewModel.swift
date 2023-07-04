//
//  TVShowDetailViewModel.swift
//  TVShows
//
//  Created by Lucas  N Santana on 03/07/23.
//

struct TVShowDetailViewModel {
    var imageUrl: String?
    var name: String?
    var summary: String
    var genre: String
    var days: String
}

struct SeasonViewModel {
    var seasonTitle: String
    var episodes: [EpisodeViewModel]
}

struct EpisodeViewModel {
    let name: String
    let number: String
    let season: String
    let summary: String
    let imageUrl: String?
    var isExpanded: Bool
}

//
//  Episode.swift
//  TVShows
//
//  Created by Lucas  N Santana on 03/07/23.
//

import Foundation

class Episode: Codable {
    let id: Int
    let name: String?
    let season, number: Int?
    let summary: String?
    let image: Images?
}

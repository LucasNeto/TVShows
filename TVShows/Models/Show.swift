//
//  Show.swift
//  TVShows
//
//  Created by Lucas  N Santana on 30/06/23.
//
import Foundation

struct Show: Codable {
    let id: Int
    let url: String?
    let name: String?
    let schedule: Schedule?
    let image: Images?
    let summary: String?
    let genres: [String]?
}

struct Schedule: Codable {
    let time: String?
    let days: [String]?
}

struct Images: Codable {
    let medium, original: String?
}

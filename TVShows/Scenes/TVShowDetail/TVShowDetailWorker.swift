//
//  TVShowDetailWorker.swift
//  TVShows
//
//  Created by Lucas  N Santana on 03/07/23.
//

import Foundation

struct TVShowDetailWorker {
    
    var service = BaseService()
    
    func loadEpisodes(by showId: Int, completion: @escaping(([Episode]?,ServiceError?)->())) {
        let endpoint = "/shows/\(showId)/episodes"
        service.doRequest(endpoint, completion: completion)
    }
}

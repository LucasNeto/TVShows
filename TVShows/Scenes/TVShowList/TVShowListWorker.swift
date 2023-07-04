//
//  TVShowListWorker.swift
//  TVShows
//
//  Created by Lucas  N Santana on 30/06/23.
//

struct TVShowListWorker {
    
    var service = BaseService()
    
    func search(by name: String, completion: @escaping(([SearchShowResponse]?,ServiceError?)->())) {
        let endpoint = "/search/shows?q=\(name)"
        service.doRequest(endpoint, completion: completion)
    }
}

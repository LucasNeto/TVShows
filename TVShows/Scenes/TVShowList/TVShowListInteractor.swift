//
//  TVShowListInteractor.swift
//  TVShows
//
//  Created by Lucas  N Santana on 30/06/23.
//
import Foundation

struct TVShowListInteractor {
    
    var presenter: TVShowListPresenter
    var worker: TVShowListWorker
    
    func searchBy(name: String?) {
        presenter.showLoading()
        worker.search(by: name ?? "") { searchResponse, error in
            presenter.hideLoading()
            if let error = error {
                presenter.presentError(error: error)
            } else if let response = searchResponse {
                let shows = response.map { $0.show }
                presenter.present(shows: shows)
            }
        }
    }
    
}

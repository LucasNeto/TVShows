//
//  TVShowListPresenter.swift
//  TVShows
//
//  Created by Lucas  N Santana on 30/06/23.
//
import Foundation

struct TVShowListPresenter {
    weak var viewController: TVShowListViewController?
    
    func present(shows: [Show]) {
        DispatchQueue.main.async {
            viewController?.displayShows(shows: shows)
        }
    }
    
    func presentError(error: ServiceError) {
        let viewModel = AlertViewModel(title: "Error", message: error.getMessage(), buttonTitle: "OK")
        DispatchQueue.main.async {
            viewController?.displayAlert(viewModel: viewModel)
        }
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            viewController?.displayLoading()
        }
    }
    func hideLoading() {
        DispatchQueue.main.async {
            viewController?.hideLoading()
        }
    }
}

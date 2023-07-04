//
//  TVShowListRouter.swift
//  TVShows
//
//  Created by Lucas  N Santana on 30/06/23.
//

struct TVShowListRouter {
    
    weak var viewController: TVShowListViewController?
    
    func goToDetail(show: Show) {
        let vc = TVShowDetailViewController()
        vc.show = show
        viewController?.show(vc, sender: nil)
    }
}

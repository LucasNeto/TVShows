//
//  TVShowListViewController.swift
//  TVShows
//
//  Created by Lucas  N Santana on 30/06/23.
//

import UIKit

class TVShowListViewController: BaseViewController {
    
    var interactor: TVShowListInteractor?
    var router: TVShowListRouter?

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchTextfield: UITextField!
    
    var items: [Show] = []
    let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(
        top: 16.0,
        left: 16.0,
        bottom: 16.0,
        right: 16.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupCollectionView()
        setupLoadingView()
    }
    
    private func setup() {
        let viewController = self
        let presenter = TVShowListPresenter(viewController: viewController)
        let worker = TVShowListWorker()
        let interactor = TVShowListInteractor(presenter: presenter, worker: worker)
        var router = TVShowListRouter(viewController: viewController)
        
        viewController.interactor = interactor
        viewController.router = router
        router.viewController = viewController
    }


    @IBAction func searchTap(_ sender: UIButton) {
        interactor?.searchBy(name: searchTextfield.text)
    }
    
    func displayShows(shows: [Show]) {
        self.items = shows
        collectionView.reloadData()
    }

    private func setupCollectionView() {
        let nib = UINib(nibName: "TVShowListCell",bundle: Bundle.main)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "TVShowListCellIdentifier")
    }
}

// MARK: UICollectionViewDataSource && UICollectionViewDelegate

extension TVShowListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TVShowListCellIdentifier", for: indexPath) as! TVShowListCell
        let show = items[indexPath.row]
        cell.set(show: show)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router?.goToDetail(show: items[indexPath.row])
    }
}

extension TVShowListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = collectionView.bounds.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return sectionInsets.left
    }
}

//
//  BaseViewController.swift
//  TVShows
//
//  Created by Lucas  N Santana on 01/07/23.
//

import UIKit

class BaseViewController: UIViewController {
    var activityIndicator: UIActivityIndicatorView?
    
    func displayLoading(){
        activityIndicator?.startAnimating()
    }
    func hideLoading(){
        activityIndicator?.stopAnimating()
    }
    func setupLoadingView(){
        let size: CGFloat = 24
        let x = self.view.bounds.midX-(size/2)
        let y = self.view.bounds.midY-size
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: x, y: y, width: size, height: size))
        activityIndicator?.hidesWhenStopped = true
        guard let activityIndicator = activityIndicator else { return }
        self.view.addSubview(activityIndicator)
    }
    
    func displayAlert(viewModel: AlertViewModel) {
        let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: viewModel.buttonTitle, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


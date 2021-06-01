//
//  UIAlertController+Extensions.swift
//  Arandworld
//
//  Created by Willa on 02/06/21.
//

import UIKit

fileprivate let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
fileprivate let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

extension UIAlertController {
    
    static func startAlertLoading(vc: UIViewController) {
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .medium
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
        vc.present(alert, animated: true, completion: nil)
    }
    
    static func stopAlertLoading() {
        loadingIndicator.stopAnimating()
        alert.dismiss(animated: true, completion: nil)
    }
    
}

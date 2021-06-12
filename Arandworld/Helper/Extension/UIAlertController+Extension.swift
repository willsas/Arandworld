//
//  UIAlertController+Extensions.swift
//  Arandworld
//
//  Created by Willa on 02/06/21.
//

import UIKit



extension UIAlertController {

    class func show(_ message: String, from controller: UIViewController) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        controller.present(alert, animated: true, completion: nil)
    }
    
    class func show(_ message: String, actions: [UIAlertAction]? = nil, from controller: UIViewController) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        actions?.forEach({alert.addAction($0)})
        controller.present(alert, animated: true, completion: nil)
    }
    
}

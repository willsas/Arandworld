//
//  Coordinator.swift
//  Arandworld
//
//  Created by Willa on 12/06/21.
//

import UIKit

protocol Coordinatorable {
    var nav: UINavigationController? { get }
    var vc: UIViewController {get set}
    init(vc: UIViewController)
}


final class MainArCoordinator: Coordinatorable {
    
    internal var nav: UINavigationController? {
        return vc.navigationController
    }
    
    internal var vc: UIViewController
    
    init(vc: UIViewController) {
        self.vc = vc
    }
    
    func presentToLoginViewController() {
        let target = LoginViewController()
        target.modalPresentationStyle = .overCurrentContext
        vc.present(target, animated: true, completion: nil)
    }
}


class LoginCoordinator: Coordinatorable {
    
    var nav: UINavigationController? {
        vc.navigationController
    }
    
    var vc: UIViewController
    
    required init(vc: UIViewController) {
        self.vc = vc
    }
    
    func dismissToMainARViewController() {
        vc.dismiss(animated: true, completion: nil)
    }
    
    
}

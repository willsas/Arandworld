//
//  MainARViewController.swift
//  Arandworld
//
//  Created by Willa on 02/06/21.
//

import UIKit
import ARKit
import RealityKit

class MainARViewController: UIViewController {
    
    private let vm = MainARViewModel()
    private lazy var coordinator = MainArCoordinator(vc: self)

    @IBOutlet weak var arViewOutlet: ARView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vm.delegate = self
        arViewOutlet.session.run(ARWorldTrackingConfiguration(), options: .removeExistingAnchors)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        displayIPActivityAlert()
        vm.requestCheckLogin()
    }

}


extension MainARViewController: MainArViewModelDelegate {
    func onError(message: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            self.dismissIPActivityAlert()
            self.showTopSnackBarView(.error(message))
        }
        
    }
    
    func responseCheckLogin(isLoggedIn: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            self.dismissIPActivityAlert {
                if !isLoggedIn {
                    self.coordinator.presentToLoginViewController()
                } else {
                    self.vm.requestRelogin()
                }
            }
          
        }
        
    }
    
    
}

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
    
    private let viewModel = MainARViewModel()

    @IBOutlet weak var arViewOutlet: ARView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arViewOutlet.session.run(ARWorldTrackingConfiguration(), options: .removeExistingAnchors)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIAlertController.startAlertLoading(vc: self)
        viewModel.checkLogin(completion: {
            UIAlertController.stopAlertLoading()
            let target = LoginViewController()
            target.modalPresentationStyle = .overCurrentContext
            self.present(target, animated: true, completion: nil)
        })
        
        
    }



}

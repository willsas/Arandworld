//
//  MainARViewModel.swift
//  Arandworld
//
//  Created by Willa on 02/06/21.
//

import Foundation
import ArandworldEngine


protocol MainArViewModelDelegate: AnyObject {
    func onError(message: String)
    func responseCheckLogin(isLoggedIn: Bool)
}


class MainARViewModel {
    
    // Service
    private var authService = ArandWorldCore.Service.authService
    
    weak var delegate: MainArViewModelDelegate?
    
    func requestCheckLogin() {
        authService.isLoggedIn { [delegate] response in
            switch response {
            case .success(let value):
                delegate?.responseCheckLogin(isLoggedIn: value)
            case .failure(let err):
                delegate?.onError(message: err.localizedDescription)
            }
        }
    }
    
    func requestRelogin() {
        authService.signOut { [weak self] response in
            switch response {
            case .success(let value):
                self?.requestCheckLogin()
            case .failure(let err):
                self?.delegate?.onError(message: err.localizedDescription)
            }
        }
    }
}

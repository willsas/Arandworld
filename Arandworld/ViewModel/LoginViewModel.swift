//
//  LoginViewModel.swift
//  Arandworld
//
//  Created by Willa on 25/05/21.
//

import Foundation
import ArandworldEngine


protocol LoginViewModelDelegate: class {
    func onLogin(onError: Error?)
}

class LoginViewModel {
    
    var username: String?
    var password: String?
    weak var delegate: LoginViewModelDelegate?
    
    private var dependency = DependencyContainer(networkService: URLSessionNetworkService())
    private lazy var authService = dependency.createAuthService()
    
    init() {
        authService.authDelegate = self
    }
    
    func login() {
        authService.signIn(username: username ?? "", password: password ?? "")
    }
}


extension LoginViewModel: AuthServiceDelegate {
    func onLogin(onError: Error?) {
        delegate?.onLogin(onError: onError)
    }
    
}

//
//  LoginViewModel.swift
//  Arandworld
//
//  Created by Willa on 25/05/21.
//

import Foundation
import ArandworldEngine


protocol LoginViewModelDelegate: AnyObject {
    func signInResponse(isSuccess: Bool)
    func registerResponse(isSuccess: Bool)
    func confirmRegisterResponse(isSuccess: Bool)
    func onError(msg: String)
}

class LoginViewModel {
    
    var username: String?
    var password: String?
    var email: String?
    
    private lazy var authService = ArandWorldCore.Service.authService
    
    weak var delegate: LoginViewModelDelegate?
    
    func requestSignin() {
        
        guard let username = username,
              !username.isEmpty else {
            delegate?.onError(msg: "Error: Username cannot be empty")
            return
        }
        
        guard let password = password,
              !password.isEmpty else {
            delegate?.onError(msg: "Error: Password cannot be empty")
            return
        }
        
        authService.signIn(username: username , password: password) { [delegate] response in
            switch response {
            case .success(let result):
                delegate?.signInResponse(isSuccess: result)
            case .failure(let err):
                delegate?.onError(msg: err.localizedDescription)
            }
        }
    }
    
    func requestRegister() {
        
        guard let username = username,
              !username.isEmpty else {
            delegate?.onError(msg: "Error: Username cannot be empty")
            return
        }
        
        guard let password = password,
              !password.isEmpty else {
            delegate?.onError(msg: "Error: Password cannot be empty")
            return
        }
        
        guard let email = email,
              !email.isEmpty else {
            delegate?.onError(msg: "Error: Email cannot be empty")
            return
        }
        
        authService.signUp(username: username, password: password, email: email) { [delegate] response in
            switch response {
            case .success(let result):
                delegate?.registerResponse(isSuccess: result)
            case .failure(let err):
                delegate?.onError(msg: err.localizedDescription)
            }
        }
    }
    
    func requestConfirmRegister(code: String) {
        
        guard let username = username,
              !username.isEmpty else {
            delegate?.onError(msg: "Error: Username cannot be empty")
            return
        }
        
        guard let password = password,
              !password.isEmpty else {
            delegate?.onError(msg: "Error: Password cannot be empty")
            return
        }
        
        authService.confirmSignUp(username: username, code: code) { [delegate] response in
            switch response {
            case .success(let result):
                delegate?.confirmRegisterResponse(isSuccess: result)
            case .failure(let err):
                delegate?.onError(msg: err.localizedDescription)
            }
        }
    }
    
}

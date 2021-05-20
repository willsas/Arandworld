//
//  FactoryProtocol.swift
//  Arandworld
//
//  Created by Willa on 16/05/21.
//

import Foundation
import Combine


protocol AuthenticationService {
    
    @discardableResult
    func signUp(username: String, password: String, email: String, completion: ((Result<UserModel, Error>) -> Void)?) -> AnyCancellable
    
    @discardableResult
    func confirmSignUp(username: String, code: String) -> AnyCancellable
    
    @discardableResult
    func signIn(username: String, password: String) -> AnyCancellable
    
}

//
//  LoginViewController.swift
//  Arandworld
//
//  Created by Willa on 16/05/21.
//

import UIKit
import Combine

class LoginViewController: UIViewController {
    
//    var cancelables: Set<AnyCancellable> = Set<AnyCancellable>()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        signUp(username: "", password: "", email: "").store(in: &cancelables)
//    }
//
//    func signUp(username: String, password: String, email: String) -> AnyCancellable {
//        let userAttributes = [AuthUserAttribute(.email, value: email)]
//        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
//        let sink = Amplify.Auth.signUp(username: username, password: password, options: options)
//            .resultPublisher
//            .sink {
//                if case let .failure(authError) = $0 {
//                    print("An error occurred while registering a user \(authError)")
//                }
//            }
//            receiveValue: { signUpResult in
//                if case let .confirmUser(deliveryDetails, _) = signUpResult.nextStep {
//                    print("Delivery details \(String(describing: deliveryDetails))")
//                } else {
//                    print("SignUp Complete")
//                }
//            }
//
//        return sink
//    }



}

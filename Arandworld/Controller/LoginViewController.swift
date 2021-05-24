//
//  LoginViewController.swift
//  Arandworld
//
//  Created by Willa on 16/05/21.
//

import UIKit


class LoginViewController: UIViewController {
    
    @IBOutlet weak var userNameTFOutlet: UITextField!
    @IBOutlet weak var passwordTFOutlet: UITextField!
    
    private let loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginViewModel.delegate = self
        setupTextField()
    }
    
    
    private func setupTextField() {
        userNameTFOutlet.delegate = self
        passwordTFOutlet.delegate = self
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        loginViewModel.login()
    }
}

extension LoginViewController: LoginViewModelDelegate {
    func onLogin(onError: Error?) {
        print("adfasfasdf, error: \(onError)")
    }
}


extension LoginViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        switch textField {
        case userNameTFOutlet:
            loginViewModel.username = textField.text
        case passwordTFOutlet:
            loginViewModel.password = textField.text
        default:
            break
        }
    }
}

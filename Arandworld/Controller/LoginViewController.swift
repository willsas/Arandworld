//
//  LoginViewController.swift
//  Arandworld
//
//  Created by Willa on 16/05/21.
//

import UIKit


class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTFOutlet: UITextField!
    @IBOutlet weak var userNameTFOutlet: UITextField!
    @IBOutlet weak var passwordTFOutlet: UITextField!
    @IBOutlet weak var segmentedControlOutlet: UISegmentedControl!
    @IBOutlet weak var loginBtnOutlet: UIButton!
    
    private let loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        setupNavigationItem()
        setupSegmentedControl()
        loginViewModel.delegate = self
        setupBlurryEffect()
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "Login"
    }
    
    private func setupSegmentedControl() {
        emailTFOutlet.isHidden = true
        segmentedControlOutlet.addTarget(self, action: #selector(LoginViewController.handleSegment(_:)), for: .valueChanged)
        segmentedControlOutlet.tintColor = .systemBlue
        segmentedControlOutlet.selectedSegmentIndex = 0
        segmentedControlOutlet.sendActions(for: .valueChanged)
        segmentedControlOutlet.setTitle("Login", forSegmentAt: 0)
        segmentedControlOutlet.setTitle("Register", forSegmentAt: 1)
    }
    
    @objc
    private func handleSegment(_ sender: UISegmentedControl) {
        UIView.animate(withDuration: 0.3) { [emailTFOutlet, loginBtnOutlet] in
            switch sender.selectedSegmentIndex {
            // login
            case 0:
                emailTFOutlet?.isHidden = true
                loginBtnOutlet?.setTitle("Login", for: .normal)
            // register
            case 1:
                emailTFOutlet?.isHidden = false
                loginBtnOutlet?.setTitle("Register", for: .normal)
            default:
                break
            }
        }
    
    }
    
    private func setupBlurryEffect() {
        view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: .systemThickMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.frame
        self.view.insertSubview(blurEffectView, at: 0)
    }
    
    
    private func setupTextField() {
        emailTFOutlet.delegate = self
        userNameTFOutlet.delegate = self
        passwordTFOutlet.delegate = self
        
        [emailTFOutlet, userNameTFOutlet, passwordTFOutlet].forEach { (tf) in
            tf?.backgroundColor = UIColor.black.withAlphaComponent(0.1)
            tf?.layer.borderWidth = 0
            
        }
        
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

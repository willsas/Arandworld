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
    
    private let vm = LoginViewModel()
    private lazy var coordinator = LoginCoordinator(vc: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        setupNavigationItem()
        setupSegmentedControl()
        setupLoginButton()
        vm.delegate = self
        setupBlurryEffect()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        loginBtnOutlet.layer.cornerRadius = 2
    }
    
    private func showOTPConfirmation() {
        showInputDialog(title: "Confirm OTP",
                        subtitle: "Input OTP that sent to \(vm.email ?? "Your Email")",
                        inputPlaceholder: "OTP Code",
                        inputKeyboardType: .numberPad,
                        actionHandler:  { [vm] code in
                            vm.requestConfirmRegister(code: code!)
                        })
        
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
        emailTFOutlet.keyboardType = .emailAddress
        userNameTFOutlet.delegate = self
        passwordTFOutlet.delegate = self
        passwordTFOutlet.isSecureTextEntry = true

        [emailTFOutlet, userNameTFOutlet, passwordTFOutlet].forEach { (tf) in
            tf?.backgroundColor = UIColor.black.withAlphaComponent(0.1)
            tf?.layer.borderWidth = 0
            
        }
        
    }
    
    private func setupLoginButton() {
        loginBtnOutlet.backgroundColor = .systemBlue
        loginBtnOutlet.setTitleColor(.white, for: .normal)
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        displayIPActivityAlert()
        switch segmentedControlOutlet.selectedSegmentIndex {
        // login
        case 0:
            vm.requestSignin()
        // register
        case 1:
            vm.requestRegister()
        default:
            break
        }
        
    }
}

extension LoginViewController: LoginViewModelDelegate {
    
    func signInResponse(isSuccess: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            self.dismissIPActivityAlert()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if isSuccess {
                    self.showTopSnackBarView(.success("Success Login"))
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.coordinator.dismissToMainARViewController()
                    }
                } else {
                    self.showTopSnackBarView(.error("Failed to login"))
                }
            }
         
        }
      
    }
    
    func registerResponse(isSuccess: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            self.dismissIPActivityAlert()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if isSuccess {
                    self.showOTPConfirmation()
                } else {
                    self.showTopSnackBarView(.error("Failed to register"))
                }
            }
         
        }
    }
    
    func confirmRegisterResponse(isSuccess: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            self.dismissIPActivityAlert()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if isSuccess {
                    self.showTopSnackBarView(.success("Success Register"))
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.coordinator.dismissToMainARViewController()
                    }
                } else {
                    self.showTopSnackBarView(.error("Failed to Confirm"))
                }
            }
         
        }
    }
    
    func onError(msg: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            self.dismissIPActivityAlert()
            self.showTopSnackBarView(.error(msg))
        }
        
    }
    
}


extension LoginViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        switch textField {
        case userNameTFOutlet:
            vm.username = textField.text
        case passwordTFOutlet:
            vm.password = textField.text
        case emailTFOutlet:
            vm.email = textField.text
        default:
            break
        }
    }
}

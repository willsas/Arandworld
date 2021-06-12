//
//  UIViewController+Extension.swift
//  Arandworld
//
//  Created by Willa on 12/06/21.
//

import UIKit

extension UIViewController {
    
    //MARK: - Activity Indicator
    private struct ActivityIndicatorData {
        static var activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    }

    private func addActivityIndicator() {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 40,height: 40)
        ActivityIndicatorData.activityIndicator.style = .large
        ActivityIndicatorData.activityIndicator.startAnimating()
        vc.view.addSubview(ActivityIndicatorData.activityIndicator)
        self.setValue(vc, forKey: "contentViewController")
    }

    private func dismissActivityIndicator(completion: (() -> Void)? ) {
        ActivityIndicatorData.activityIndicator.stopAnimating()
        self.dismiss(animated: false, completion: completion)
    }
    
    private struct activityAlert {
        static var activityIndicatorAlert: UIAlertController?
    }
    
    func displayIPActivityAlert() {
        activityAlert.activityIndicatorAlert = UIAlertController(title: "Please wait...", message: nil , preferredStyle: .alert)
        activityAlert.activityIndicatorAlert!.addActivityIndicator()
        var topController: UIViewController = UIApplication.shared.windows.first!.rootViewController!
        while ((topController.presentedViewController) != nil) {
            topController = topController.presentedViewController!
        }
        topController.present(activityAlert.activityIndicatorAlert!, animated: true, completion :nil)
    }
    
    func dismissIPActivityAlert(completion: (() -> Void)? = nil) {
        activityAlert.activityIndicatorAlert?.dismissActivityIndicator(completion: completion)
        activityAlert.activityIndicatorAlert = nil
    }
    
    // MARK: - TextField on UIalert
    func showInputDialog(title: String? = nil,
                         subtitle: String? = nil,
                         actionTitle: String? = "Confirm",
                         cancelTitle: String? = "Cancel",
                         inputPlaceholder: String? = nil,
                         inputKeyboardType: UIKeyboardType = UIKeyboardType.default,
                         cancelHandler: ((UIAlertAction) -> Void)? = nil,
                         actionHandler: ((_ text: String?) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = inputPlaceholder
            textField.keyboardType = inputKeyboardType
        }
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { (action:UIAlertAction) in
            guard let textField =  alert.textFields?.first else {
                actionHandler?(nil)
                return
            }
            actionHandler?(textField.text)
        }))
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelHandler))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: - TopSnackBar
    enum SnackBarType {
        case error(String)
        case success(String)
    }
    func showTopSnackBarView(_ type: SnackBarType) {
        switch type {
        case .success(let msg):
            view.addSubview(TopSnackBarView(message: msg, isError: false))
        case .error(let msg):
            view.addSubview(TopSnackBarView(message: msg, isError: true))
        }
    }
    
}


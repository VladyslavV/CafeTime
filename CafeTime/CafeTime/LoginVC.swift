//
//  LoginVC.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 1/26/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController, LoginViewDelegate {
    
    private let mainView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
    }
    
    private func setUp() {
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(mainView)
        mainView.delegate = self
        
        self.navigationController?.navigationBar.topItem?.title = "Login"
        
        mainView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view)
        }
    }
    
    
    //MARK: Main View Delegate
    
    func loginButtonPressed() {
        
        let authManager = AuthManager.shared
        
        let email = mainView.emailTextField.text!
        let password = mainView.passwordTextField.text!
        
        let errorString = authManager.checkEmail(email: email, andPassword: password)
        
        if errorString != "" {
            self.presentAlert(message: errorString)
            return
        }
        
        authManager.authenticateUser(email: email, password: password, rememberUser: mainView.autoLoginCheckBox.isChecked()) { [weak self] (error, success) in
            
            guard let weakSelf = self else { return }
            
            if success {
                weakSelf.dismiss(animated: true, completion: nil)
            }
                
            else {
                weakSelf.presentAlert(message: error)
            }
        }
    }
    
    private func presentAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func signUpButtonPressed() {
        self.navigationController?.pushViewController(SignUpVC(), animated: true)
    }
    
    
    deinit {
        print("object \( String(describing: (self))) dealloced")
    }
    
}

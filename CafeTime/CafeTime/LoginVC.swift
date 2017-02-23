//
//  LoginVC.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 1/26/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import FirebaseAuth
import PKHUD

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
        
        self.navigationController?.navigationBar.topItem?.title = NSLocalizedString("loginvc.navigation.title", comment: "")
        
        mainView.snp.makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
        }
    }
    
    //MARK: Main View Delegate
    
    func loginButtonPressed() {
        
        let email = mainView.emailTextField.text!
        let password = mainView.passwordTextField.text!
        
        
        if let auth = Remote.serverAccess()?.auth {
            HUD.show(.progress)

            auth.authenticateUser(email: email, password: password, rememberUser: mainView.autoLoginCheckBox.isChecked()) { [weak self] (error, success) in
                
                guard let weakSelf = self else { return }
                
                if success {
                    HUD.flash(.success,delay: 1)
                    weakSelf.dismiss(animated: true, completion: nil)
                }
                    
                else {
                    HUD.flash(.error, onView: self?.view, delay: 0.2, completion: { (end) in
                        weakSelf.presentAlert(message: error)
                    })
                }
            }
        }
        else {
            self.presentAlert(message: NSLocalizedString("allert.title.no.internet", comment: ""))
        }
    }
    
    // MARK: Actions
    
    func signUpButtonPressed() {
        self.navigationController?.pushViewController(SignUpVC(), animated: true)
    }
    
    
    deinit {
        print("object \( String(describing: (self))) dealloced")
    }
    
}

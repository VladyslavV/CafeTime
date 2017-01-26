//
//  SignUpVC.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 1/26/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SnapKit
import FirebaseAuth

class SignUpVC: UIViewController, SignUpViewDelegate {
    
    private let mainView = SignUpView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
    }
    
    private func setUp() {
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(mainView)
        mainView.delegate = self
        
        mainView.snp.makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
        }
    }
    
    func signUpButtonPressed() {
        
        guard let email = mainView.emailTextField.text, let password = mainView.passwordTextField.text else {
            print("enter credentials")
            return
        }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password) {
            [weak self] (user, error) in
            
            guard let weakSelf = self else { return }
            
            if error != nil {
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                weakSelf.present(alertController, animated: true, completion: nil)
            }
            print("You have successfully signed up")
            
            // save credentials
            let save = UserDefaults.standard
            save.setValue(email, forKey: Globals.savedEmail)
            save.setValue(password, forKey: Globals.savedPassword)
            save.synchronize()
            
            self?.dismiss(animated: true, completion: nil)
        }
    }
    

    deinit {
        print("object \( String(describing: (self))) dealloced")
    }
    
}

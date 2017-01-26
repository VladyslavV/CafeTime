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
    
    func loginButtonPressed() {
        
        guard let email = mainView.emailTextField.text, let password = mainView.passwordTextField.text else {
            print("enter credentials")
            return
        }
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { [weak self] (user, error) in
            
            guard let weakSelf = self else { return }
            
            if error == nil {
                print("You have successfully logged in")
    
                // save credentials
                let save = UserDefaults.standard
                save.setValue(email, forKey: Globals.savedEmail)
                save.setValue(password, forKey: Globals.savedPassword)
                save.synchronize()
                
                self?.dismiss(animated: true, completion: nil)
            }
            else {
                //Tells the user that there is an error and then gets firebase to tell them the error
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                weakSelf.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    func signUpButtonPressed() {
        self.navigationController?.pushViewController(SignUpVC(), animated: true)
    }
    
    deinit {
        print("object \( String(describing: (self))) dealloced")
    }
    
}

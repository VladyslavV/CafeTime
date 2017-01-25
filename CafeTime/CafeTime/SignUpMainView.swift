//
//  LoginMainView.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 1/25/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SnapKit
import FirebaseAuth

protocol SignUpMainViewDelegate : class {
    func signUpButtonPressed(vc : UIViewController)
}

class SignUpMainView: UIView {
    
    weak var delegate : SignUpMainViewDelegate?
    
    // MARK: Vars
    let signUpButton : UIButton = {
        let myVar = UIButton(type: .system)
        myVar.backgroundColor = UIColor.green
        myVar.setTitle("Login", for: .normal)
        myVar.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        
        return myVar
    }()
    
    let emailTextField : UITextField = {
        let myVar = UITextField()
        myVar.placeholder = "email"
        myVar.autocapitalizationType = .none
        myVar.backgroundColor = UIColor.red
        myVar.textAlignment = .center
        return myVar
    }()
    
    
    let passwordTextField : UITextField = {
        let myVar = UITextField()
        myVar.placeholder = "password"
        myVar.autocapitalizationType = .none
        myVar.backgroundColor = UIColor.red
        myVar.textAlignment = .center
        myVar.isSecureTextEntry = true
        return myVar
    }()
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        self.backgroundColor = UIColor.orange
        
        self.addSubview(emailTextField)
        self.addSubview(passwordTextField)
        self.addSubview(signUpButton)
        
        let screenHeight = UIScreen.main.bounds.size.height
        
        emailTextField.snp.remakeConstraints { (make) -> Void in
            make.width.equalTo(self.snp.width).multipliedBy(0.7)
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY).offset(-screenHeight * 0.15)
            make.height.equalTo(self.snp.height).multipliedBy(0.05)
        }
        
        passwordTextField.snp.remakeConstraints { (make) -> Void in
            make.width.equalTo(self.snp.width).multipliedBy(0.7)
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(emailTextField.snp.bottom).offset(10)
            make.height.equalTo(self.snp.height).multipliedBy(0.05)
        }
        
        signUpButton.snp.remakeConstraints { (make) -> Void in
            make.width.equalTo(self.snp.width).multipliedBy(0.7)
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.height.equalTo(self.snp.height).multipliedBy(0.05)
        }
    }
    
    //MARK: Actions
    
    @objc private func signUp() {
        if emailTextField.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.delegate?.signUpButtonPressed(vc: alertController)
        }
        else {
            FIRAuth.auth()?.createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                
                if error == nil {
                    print("You have successfully signed up")
                    self.delegate?.signUpButtonPressed(vc: AuthenticatedUserVC())
                }
                else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.delegate?.signUpButtonPressed(vc: alertController)
                }
            }
        }
    }
}

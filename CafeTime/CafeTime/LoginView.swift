//
//  LoginVC.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 1/26/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SnapKit
import FirebaseAuth

protocol LoginViewDelegate : class {
    func loginButtonPressed()
    func signUpButtonPressed()
}

class LoginView : UIView {

    weak var delegate : LoginViewDelegate?
    
    // MARK: Vars
    let signUpButton : UIButton = {
        let myVar = UIButton(type: .system)
        myVar.backgroundColor = UIColor.green
        myVar.setTitle("Sign Up", for: .normal)
        myVar.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        
        return myVar
    }()
    
    let loginButton : UIButton = {
        let myVar = UIButton(type: .system)
        myVar.backgroundColor = UIColor.green
        myVar.setTitle("Login", for: .normal)
        myVar.addTarget(self, action: #selector(login), for: .touchUpInside)
        
        return myVar
    }()
    
    let emailTextField : UITextField = {
        let myVar = UITextField()
        myVar.placeholder = "email"
        myVar.autocapitalizationType = .none
        myVar.backgroundColor = UIColor.lightGray
        myVar.textAlignment = .center
        return myVar
    }()
    
    
    let passwordTextField : UITextField = {
        let myVar = UITextField()
        myVar.placeholder = "password"
        myVar.autocapitalizationType = .none
        myVar.backgroundColor = UIColor.lightGray
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
        self.backgroundColor = UIColor.clear
        
        self.addSubview(loginButton)
        self.addSubview(emailTextField)
        self.addSubview(passwordTextField)
        self.addSubview(signUpButton)
        
        self.setUpConstraints()
    }
    
    private func setUpConstraints() {
        
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
        
        loginButton.snp.remakeConstraints { (make) -> Void in
            make.leading.equalTo(passwordTextField.snp.leading)
            make.trailing.equalTo(passwordTextField.snp.trailing)
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.height.equalTo(self.snp.height).multipliedBy(0.05)
        }
        
        signUpButton.snp.remakeConstraints { (make) -> Void in
            make.leading.equalTo(passwordTextField.snp.leading)
            make.trailing.equalTo(passwordTextField.snp.trailing)
            make.height.equalTo(self.snp.height).multipliedBy(0.05)
            make.bottom.equalTo(self.snp.bottom).offset(-20)
        }
        
       
    }
    
    //MARK: Actions
    
    @objc private func signUp() {
        self.delegate?.signUpButtonPressed()
    }
    
    @objc private func login() {
        self.delegate?.loginButtonPressed()
    }

    
}

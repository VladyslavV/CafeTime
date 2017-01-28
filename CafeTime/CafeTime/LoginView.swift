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
import M13Checkbox

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
        myVar.setTitle( NSLocalizedString("loginvc.signup.button", comment: ""), for: .normal)
        myVar.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        
        return myVar
    }()
    
    let autoLoginCheckBox : M13Checkbox = {
        let myVar = M13Checkbox()
        myVar.isUserInteractionEnabled = true
        myVar.boxType = .square
        return myVar
    }()
    
    let rememberMeLabel : UILabel = {
        let myVar = UILabel()
        myVar.backgroundColor = UIColor.red
        myVar.text = NSLocalizedString("loginvc.remember.user.label", comment: "")
        return myVar
    }()
    
    let loginButton : UIButton = {
        let myVar = UIButton(type: .system)
        myVar.backgroundColor = UIColor.green
        myVar.setTitle(NSLocalizedString("loginvc.login.button", comment: ""), for: .normal)
        myVar.addTarget(self, action: #selector(login), for: .touchUpInside)
        
        return myVar
    }()
    
    let emailTextField : UITextField = {
        let myVar = UITextField()
        myVar.placeholder = NSLocalizedString("loginvc.email.textfield", comment: "")
        myVar.autocapitalizationType = .none
        myVar.textAlignment = .center
        myVar.backgroundColor = UIColor.lightGray
        return myVar
    }()
    
    
    let passwordTextField : UITextField = {
        let myVar = UITextField()
        myVar.placeholder = NSLocalizedString("loginvc.password.textfield", comment: "")
        myVar.autocapitalizationType = .none
        myVar.textAlignment = .center
        myVar.backgroundColor = UIColor.lightGray
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
        
        self.addSubviews([loginButton, emailTextField, passwordTextField, signUpButton, autoLoginCheckBox, rememberMeLabel])
        
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
            make.width.equalTo(self.snp.width).multipliedBy(0.7)
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.height.equalTo(self.snp.height).multipliedBy(0.05)
        }
        
        rememberMeLabel.snp.remakeConstraints { (make) -> Void in
            make.leading.equalTo(loginButton.snp.leading)
            make.trailing.equalTo(autoLoginCheckBox.snp.leading).offset(-5)
            make.top.equalTo(loginButton.snp.bottom).offset(10)
            make.height.equalTo(self.snp.height).multipliedBy(0.05)
        }
        
        autoLoginCheckBox.snp.remakeConstraints { (make) -> Void  in
            make.width.height.equalTo(loginButton.snp.height)
            make.trailing.equalTo(loginButton.snp.trailing)
            make.centerY.equalTo(rememberMeLabel.snp.centerY)
        }
        
        signUpButton.snp.remakeConstraints { (make) -> Void in
            make.leading.equalTo(passwordTextField.snp.leading)
            make.trailing.equalTo(passwordTextField.snp.trailing)
            make.height.equalTo(self.snp.height).multipliedBy(0.05)
            make.bottom.equalTo(self.snp.bottom).offset(-20)
        }
        
    }
    
    //MARK: Touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        passwordTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
    }
    
    //MARK: Delegate Actions
    
    @objc private func signUp() {
        self.delegate?.signUpButtonPressed()
    }
    
    @objc private func login() {
        self.delegate?.loginButtonPressed()
    }
}


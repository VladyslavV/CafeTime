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
import M13Checkbox

protocol SignUpViewDelegate : class {
    func signUpButtonPressed()
}

class SignUpView: UIView {
    
    weak var delegate : SignUpViewDelegate?
    
    // MARK: Vars
    let autoLoginCheckBox : M13Checkbox = {
        let myVar = M13Checkbox(frame: CGRect.zero)
        myVar.boxType = .square
        return myVar
    }()
    
    let rememberMeLabel : UILabel = {
        let myVar = UILabel()
        myVar.backgroundColor = UIColor.red
        myVar.text = "Remember me"
        return myVar
    }()

    let cafeLogo : UIImageView = {
        let myVar = UIImageView()
        myVar.image = UIImage(named: "cafe")
        return myVar
    }()
    
    let signUpButton : UIButton = {
        let myVar = UIButton(type: .system)
        myVar.backgroundColor = UIColor.green
        myVar.setTitle("Sign Up", for: .normal)
        myVar.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        
        return myVar
    }()
    
    let emailTextField : UITextField = {
        let myVar = UITextField()
        myVar.placeholder = "Email"
        myVar.autocapitalizationType = .none
        myVar.backgroundColor = UIColor.lightGray
        myVar.textAlignment = .center
        return myVar
    }()
    
    
    let passwordTextField : UITextField = {
        let myVar = UITextField()
        myVar.placeholder = "Password"
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
        self.backgroundColor = UIColor.white
        
        self.addSubview(emailTextField)
        self.addSubview(passwordTextField)
        self.addSubview(signUpButton)
        self.addSubview(autoLoginCheckBox)
        self.addSubview(cafeLogo)
        self.addSubview(rememberMeLabel)
        
        self.setUpConstraints()
    }
    
    //MARK: Actions
    
    @objc private func signUp() {
        self.delegate?.signUpButtonPressed()
    }
        
    private func setUpConstraints() {
        
        cafeLogo.snp.remakeConstraints { (make) -> Void in
            make.width.equalTo(self.snp.width).multipliedBy(0.7)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(self.snp.height).multipliedBy(0.2)
            make.top.equalTo(self.snp.top).offset(10)
        }
        
        emailTextField.snp.remakeConstraints { (make) -> Void in
            make.top.equalTo(cafeLogo.snp.bottom).offset(25)
            make.width.equalTo(self.snp.width).multipliedBy(0.7)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(self.snp.height).multipliedBy(0.05)
        }
        
        passwordTextField.snp.remakeConstraints { (make) -> Void in
            make.top.equalTo(emailTextField.snp.bottom).offset(10)
            make.width.equalTo(self.snp.width).multipliedBy(0.7)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(self.snp.height).multipliedBy(0.05)
        }
        
        signUpButton.snp.remakeConstraints { (make) -> Void in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.leading.equalTo(passwordTextField.snp.leading)
            make.trailing.equalTo(passwordTextField.snp.trailing)
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.height.equalTo(self.snp.height).multipliedBy(0.05)
        }
        
        rememberMeLabel.snp.remakeConstraints { (make) -> Void in
            make.leading.equalTo(signUpButton.snp.leading)
            make.trailing.equalTo(autoLoginCheckBox.snp.leading).offset(-5)
            make.top.equalTo(signUpButton.snp.bottom).offset(10)
            make.height.equalTo(signUpButton.snp.height)
        }
        
        autoLoginCheckBox.snp.remakeConstraints { (make) -> Void in
            make.width.height.equalTo(signUpButton.snp.height)
            make.trailing.equalTo(signUpButton.snp.trailing)
            make.centerY.equalTo(rememberMeLabel.snp.centerY)
        }
    }
    
    
    
}

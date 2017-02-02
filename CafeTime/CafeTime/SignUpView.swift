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

enum UserType: Int {
    case customer
    case cafe
}

protocol SignUpViewDelegate : class {
    func signUpUser(user: User)
    func chooseLogoTapped()
}


let cornerRadius : CGFloat = 5.0

class SignUpView: UIView, UITextFieldDelegate {
    
    let countries = Countries().countries
    
    var user = User()
    var cafe = Cafe()

    
    weak var delegate : SignUpViewDelegate?
    
    // MARK: Vars
    let autoLoginCheckBox : M13Checkbox = {
        let myVar = M13Checkbox(frame: CGRect.zero)
        myVar.boxType = .square
        return myVar
    }()
    
    lazy var cafeLogo : UIImageView = {
        let myVar = UIImageView()
        myVar.isUserInteractionEnabled = true
        myVar.image = UIImage(named: "image_placeholder")
        myVar.contentMode = .scaleAspectFit
        myVar.layer.borderColor = UIColor.black.cgColor
        myVar.layer.borderWidth = 2.0
        myVar.layer.cornerRadius = 15
        myVar.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chooseLogoImage)))
        return myVar
    }()
    
    
    
    let rememberMeLabel : UILabel = {
        let myVar = UILabel()
        myVar.backgroundColor = UIColor.red
        myVar.text = NSLocalizedString("signupvc.remembermy.label", comment: "")
        myVar.layer.cornerRadius = cornerRadius
        return myVar
    }()
    
    
    let signUpButton : UIButton = {
        let myVar = UIButton(type: .system)
        myVar.backgroundColor = UIColor.green
        myVar.setTitle(NSLocalizedString("signupvc.signup.button", comment: ""), for: .normal)
        myVar.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        myVar.layer.cornerRadius = cornerRadius
        return myVar
    }()
    
    lazy var nameTextField : UITextField = {
        let myVar = UITextField()
        myVar.autocapitalizationType = .words
        myVar.backgroundColor = UIColor.lightGray
        myVar.textAlignment = .center
        myVar.layer.cornerRadius = cornerRadius
        myVar.delegate = self
        return myVar
    }()
    
    lazy var emailTextField : UITextField = {
        let myVar = UITextField()
        myVar.placeholder = NSLocalizedString("signupvc.email.textfield", comment: "")
        myVar.autocapitalizationType = .none
        myVar.backgroundColor = UIColor.lightGray
        myVar.textAlignment = .center
        myVar.layer.cornerRadius = cornerRadius
        myVar.delegate = self
        return myVar
    }()
    
    lazy var countryTextField : UITextField = {
        let myVar = UITextField()
        myVar.placeholder = NSLocalizedString("signupvc.country.textfield", comment: "")
        myVar.backgroundColor = UIColor.lightGray
        myVar.textAlignment = .center
        myVar.layer.cornerRadius = cornerRadius
        let pickerView = CountriesPickerView(textField: myVar)
        myVar.inputView = pickerView
        myVar.delegate = self
        return myVar
    }()
    
    lazy var foodTypeTextField : UITextField = {
        let myVar = UITextField()
        myVar.placeholder = NSLocalizedString("signupvc.cafe.foodtype.textfield", comment: "")
        myVar.autocapitalizationType = .none
        myVar.backgroundColor = UIColor.lightGray
        myVar.textAlignment = .center
        myVar.layer.cornerRadius = cornerRadius;
        myVar.delegate = self
        return myVar
    }()
    
    lazy var numberOfTablesTextField : UITextField = {
        let myVar = UITextField()
        myVar.placeholder = NSLocalizedString("signupvc.numberoftables.textfield", comment: "")
        myVar.autocapitalizationType = .words
        myVar.backgroundColor = UIColor.lightGray
        myVar.textAlignment = .center
        myVar.layer.cornerRadius = cornerRadius
        myVar.keyboardType = .numberPad
        myVar.delegate = self
        return myVar
    }()
    
    lazy var passwordTextField : UITextField = {
        let myVar = UITextField()
        myVar.placeholder = NSLocalizedString("signupvc.password.textfield", comment: "")
        myVar.autocapitalizationType = .none
        myVar.backgroundColor = UIColor.lightGray
        myVar.textAlignment = .center
        myVar.layer.cornerRadius = cornerRadius
        myVar.isSecureTextEntry = true
        myVar.delegate = self
        return myVar
    }()
    
    let segmentedControl : UISegmentedControl = {
        let items = [NSLocalizedString("sighnpvc.segmentedcontrol.customer.item", comment: ""),
                     NSLocalizedString("sighnpvc.segmentedcontrol.cafe.item", comment: "")]
        let myVar = UISegmentedControl(items: items)
        myVar.layer.cornerRadius = cornerRadius
        myVar.backgroundColor = UIColor.white
        myVar.tintColor = UIColor.gray
        myVar.selectedSegmentIndex = UserType.customer.rawValue
        myVar.addTarget(self, action: #selector(changeUserType(_ :)), for: .valueChanged)
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
        
        self.addSubviews([emailTextField, passwordTextField, signUpButton, autoLoginCheckBox, cafeLogo, rememberMeLabel, segmentedControl, nameTextField, foodTypeTextField, numberOfTablesTextField, countryTextField])
        
        self.setUpCustomerSignIn()
    }
    
    // MARK: Cafe
    
    private func setUpCafeSignIn() {
        nameTextField.placeholder = NSLocalizedString("signupvc.cafe.name.textfield", comment: "")
        
        self.setUpCafeConstraints()
    }
    
    private func setUpCafeConstraints() {
        
        cafeLogo.snp.remakeConstraints { (make) in
            make.width.equalTo(self.snp.width).multipliedBy(0.7)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(self.snp.height).multipliedBy(0.2)
            make.top.equalTo(self.snp.top).offset(10)
        }
        
        segmentedControl.snp.remakeConstraints { (make) in
            make.top.equalTo(cafeLogo.snp.bottom).offset(10)
            make.width.equalTo(self.snp.width).multipliedBy(0.7)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(self.snp.height).multipliedBy(0.05)
        }
        
        nameTextField.snp.remakeConstraints { (make) in
            make.top.equalTo(segmentedControl.snp.bottom).offset(20)
            make.width.equalTo(self.snp.width).multipliedBy(0.7)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(self.snp.height).multipliedBy(0.05)
        }
        
        countryTextField.snp.remakeConstraints { (make) in
            make.top.equalTo(nameTextField.snp.bottom).offset(10)
            make.width.equalTo(self.snp.width).multipliedBy(0.7)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(self.snp.height).multipliedBy(0.05)
        }
        
        foodTypeTextField.snp.remakeConstraints { (make) in
            make.top.equalTo(countryTextField.snp.bottom).offset(10)
            make.width.equalTo(self.snp.width).multipliedBy(0.7)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(self.snp.height).multipliedBy(0.05)
        }
        
        numberOfTablesTextField.snp.remakeConstraints { (make) in
            make.top.equalTo(foodTypeTextField.snp.bottom).offset(10)
            make.width.equalTo(self.snp.width).multipliedBy(0.7)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(self.snp.height).multipliedBy(0.05)
        }
        
        emailTextField.snp.remakeConstraints { (make) in
            make.top.equalTo(numberOfTablesTextField.snp.bottom).offset(10)
            make.width.equalTo(self.snp.width).multipliedBy(0.7)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(self.snp.height).multipliedBy(0.05)
        }
        
        passwordTextField.snp.remakeConstraints { (make) in
            make.top.equalTo(emailTextField.snp.bottom).offset(10)
            make.width.equalTo(self.snp.width).multipliedBy(0.7)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(self.snp.height).multipliedBy(0.05)
        }
        
        signUpButton.snp.remakeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.leading.equalTo(passwordTextField.snp.leading)
            make.trailing.equalTo(passwordTextField.snp.trailing)
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.height.equalTo(self.snp.height).multipliedBy(0.05)
        }
        
        rememberMeLabel.snp.remakeConstraints { (make) in
            make.leading.equalTo(signUpButton.snp.leading)
            make.trailing.equalTo(autoLoginCheckBox.snp.leading).offset(-5)
            make.top.equalTo(signUpButton.snp.bottom).offset(10)
            make.height.equalTo(signUpButton.snp.height)
        }
        
        autoLoginCheckBox.snp.remakeConstraints { (make) in
            make.width.height.equalTo(signUpButton.snp.height)
            make.trailing.equalTo(signUpButton.snp.trailing)
            make.centerY.equalTo(rememberMeLabel.snp.centerY)
        }
    }
    
    
    // MARK: Customer
    
    private func setUpCustomerSignIn() {
        nameTextField.placeholder = NSLocalizedString("signupvc.customer.name.textfield", comment: "")
        
        self.setUpCustomerConstraints()
    }
    
    private func setUpCustomerConstraints() {
        
        foodTypeTextField.snp.remakeConstraints { (make) in
            make.size.equalTo(CGSize.zero)
        }
        
        numberOfTablesTextField.snp.remakeConstraints { (make) in
            make.size.equalTo(CGSize.zero)
        }
        
        cafeLogo.snp.remakeConstraints { (make) in
            make.width.equalTo(self.snp.width).multipliedBy(0.7)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(self.snp.height).multipliedBy(0.2)
            make.top.equalTo(self.snp.top).offset(10)
        }
        
        segmentedControl.snp.remakeConstraints { (make) in
            make.top.equalTo(cafeLogo.snp.bottom).offset(10)
            make.width.equalTo(self.snp.width).multipliedBy(0.7)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(self.snp.height).multipliedBy(0.05)
        }
        
        nameTextField.snp.remakeConstraints { (make) in
            make.top.equalTo(segmentedControl.snp.bottom).offset(20)
            make.width.equalTo(self.snp.width).multipliedBy(0.7)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(self.snp.height).multipliedBy(0.05)
        }
        
        countryTextField.snp.remakeConstraints { (make) in
            make.top.equalTo(nameTextField.snp.bottom).offset(10)
            make.width.equalTo(self.snp.width).multipliedBy(0.7)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(self.snp.height).multipliedBy(0.05)
        }
        
        emailTextField.snp.remakeConstraints { (make) in
            make.top.equalTo(countryTextField.snp.bottom).offset(10)
            make.width.equalTo(self.snp.width).multipliedBy(0.7)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(self.snp.height).multipliedBy(0.05)
        }
        
        passwordTextField.snp.remakeConstraints { (make) in
            make.top.equalTo(emailTextField.snp.bottom).offset(10)
            make.width.equalTo(self.snp.width).multipliedBy(0.7)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(self.snp.height).multipliedBy(0.05)
        }
        
        signUpButton.snp.remakeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.leading.equalTo(passwordTextField.snp.leading)
            make.trailing.equalTo(passwordTextField.snp.trailing)
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.height.equalTo(self.snp.height).multipliedBy(0.05)
        }
        
        rememberMeLabel.snp.remakeConstraints { (make) in
            make.leading.equalTo(signUpButton.snp.leading)
            make.trailing.equalTo(autoLoginCheckBox.snp.leading).offset(-5)
            make.top.equalTo(signUpButton.snp.bottom).offset(10)
            make.height.equalTo(signUpButton.snp.height)
        }
        
        autoLoginCheckBox.snp.remakeConstraints { (make) in
            make.width.height.equalTo(signUpButton.snp.height)
            make.trailing.equalTo(signUpButton.snp.trailing)
            make.centerY.equalTo(rememberMeLabel.snp.centerY)
        }
    }
    
    //MARK: Touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        passwordTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        nameTextField.resignFirstResponder()
        foodTypeTextField.resignFirstResponder()
        numberOfTablesTextField.resignFirstResponder()
        countryTextField.resignFirstResponder()
    }
    
    //MARK: Actions
    
    @objc private func signUp() {
        switch segmentedControl.selectedSegmentIndex {
        case UserType.customer.rawValue:
            if let text = nameTextField.text {
                user.name = text
            }
            if let text = countryTextField.text {
                user.country = text
            }
            if let text = passwordTextField.text {
                user.password = text
            }
            if let text = emailTextField.text {
                user.email = text
            }
            self.delegate?.signUpUser(user: user)
            break
        case UserType.cafe.rawValue:
            if let text = nameTextField.text {
                cafe.name = text
            }
            if let text = countryTextField.text {
                cafe.country = text
            }
            if let text = passwordTextField.text {
                cafe.password = text
            }
            if let text = emailTextField.text {
                cafe.email = text
            }
            if let text = numberOfTablesTextField.text {
                cafe.numberOfTables = text
            }
            if let text = foodTypeTextField.text {
                cafe.foodtype = text
            }
            self.delegate?.signUpUser(user: cafe)
            break
        default: break
        }
    }
    
    @objc private func chooseLogoImage() {
        self.delegate?.chooseLogoTapped()
    }
    
    @objc private func changeUserType(_ segmentControl: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex {
        case UserType.customer.rawValue:
            self.setUpCustomerSignIn()
            self.clearTextFields()
            break
        case UserType.cafe.rawValue:
            self.setUpCafeSignIn()
            self.clearTextFields()
            break
        default:
            break
        }
    }
    
    func clearTextFields() {
        UITextField.cleanFields([passwordTextField,emailTextField,nameTextField,foodTypeTextField,numberOfTablesTextField, countryTextField])
    }
    
    
    // MARK: TextField Delegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == numberOfTablesTextField {
            let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
            return string.rangeOfCharacter(from: invalidCharacters, options: [], range: string.startIndex ..< string.endIndex) == nil
        }
        return true
    }
    
    
}

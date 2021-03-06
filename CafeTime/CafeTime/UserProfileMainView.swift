//
//  AuthenticatedUserMainView.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 1/25/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SnapKit
import FirebaseAuth

protocol UserProfileMainViewDelegate : class {
    func logOutButtonPressed()
    func deleteUserButtonPressed()
}


class UserProfileMainView: UIView {
    
    weak var delegate : UserProfileMainViewDelegate?
    
    // MARK: Vars
    
    private lazy var logOutButton : UIButton = {
        let myVar = UIButton(type: .system)
        myVar.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        myVar.backgroundColor = UIColor.red
        myVar.setTitle((NSLocalizedString("authenticateduservc.logout.button", comment: "")), for: .normal)
        return myVar
    }()
    
    private lazy var deleteUserButton : UIButton = {
        let myVar = UIButton(type: .system)
        myVar.addTarget(self, action: #selector(deleteUser), for: .touchUpInside)
        myVar.backgroundColor = UIColor.red
        myVar.setTitle( "Delete User" , for: .normal)
        return myVar
    }()
    
    let userProfileInfoView: UserProfileInfoView = {
        let myVar = UserProfileInfoView()
        myVar.backgroundColor = UIColor.purple
        return myVar
    }()
    
    
    // MARK: Init
    
    convenience init(forLocalUser localUser: Bool) {
        self.init()
        if !localUser {
            self.deleteUserButton.isHidden = true
            self.logOutButton.isHidden = true
            self.userProfileInfoView.sendMessageButton.isHidden = false
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        self.backgroundColor = UIColor.white
        
        self.addSubviews([logOutButton, userProfileInfoView, deleteUserButton])
        
        self.setUpConstraints()
    }
    
    private func setUpConstraints() {
        
        userProfileInfoView.snp.remakeConstraints { (make) in
            make.leading.trailing.equalTo(self)
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.centerY)
        }
        
        logOutButton.snp.remakeConstraints { (make) -> Void in
            make.height.equalTo(self.snp.height).multipliedBy(0.05)
            make.width.equalTo(self.snp.width).multipliedBy(0.7)
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.snp.bottom).offset(-150)
        }
        
        deleteUserButton.snp.remakeConstraints { (make) -> Void in
            make.leading.trailing.equalTo(logOutButton)
            make.top.equalTo(logOutButton.snp.bottom).offset(10)
            make.height.equalTo(self.snp.height).multipliedBy(0.05)
        }
    }
    
    // MARK: Actions
    
    @objc private func logOut() {
        self.delegate?.logOutButtonPressed()
    }
    
    @objc private func deleteUser() {
        self.delegate?.deleteUserButtonPressed()
    }
    
}




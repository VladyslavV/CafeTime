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

protocol AuthenticatedUserMainViewDelegate : class {
    func logOut()
}

class AuthenticatedUserMainView: UIView {
  
    weak var delegate : AuthenticatedUserMainViewDelegate?
    
    private lazy var logOutButton : UIButton = {
        let myVar = UIButton(type: .system)
        myVar.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        myVar.backgroundColor = UIColor.red
        myVar.setTitle((NSLocalizedString("authenticateduservc.logout.button", comment: "")), for: .normal)

        return myVar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        self.backgroundColor = UIColor.blue
        
        self.addSubview(logOutButton)
        
        self.setUpConstraints()
    }
    
    private func setUpConstraints() {
    
        logOutButton.snp.remakeConstraints { (make) -> Void in
            make.height.equalTo(self.snp.height).multipliedBy(0.05)
            make.width.equalTo(self.snp.width).multipliedBy(0.7)
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.snp.bottom).offset(-20)
        }
        
    }
    
    @objc private func logOut() {
        self.delegate?.logOut()
    }
    
}

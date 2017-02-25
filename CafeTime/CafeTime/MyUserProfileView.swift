//
//  MyUserProfileView.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/17/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SnapKit

protocol MyUserProfileViewDelegate: class {
    func starButtonPressed()
}



class MyUserProfileView: ReusableUserProfileView {

    weak var delegate: MyUserProfileViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviews([starButton, chatButton])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Vars
    
    let starButton: UIButton = {
        let myVar = UIButton(type: .system)
        myVar.backgroundColor = UIColor.green
        myVar.addTarget(self, action: #selector(starPessed), for: .touchUpInside)
        return myVar
    }()
    
    let chatButton: UIButton = {
        let myVar = UIButton(type: .system)
        myVar.backgroundColor = UIColor.green
        return myVar
    }()
    
    // MARK: Set Up
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
        self.setUp()
    }
    
    private func setUp() {
        
        if let parentVC = self.parentViewController as? MyUserProfileVC {
            profileImageViewFront.snp.remakeConstraints { (make) in
                make.centerX.equalTo(self.snp.centerX)
                make.width.height.equalTo(self.snp.height).multipliedBy(0.4)
                make.top.equalTo(parentVC.topLayoutGuide.snp.bottom).offset(10)
            }
        }
        
        let starButtonHelpView = UIView()
        self.addSubview(starButtonHelpView)
        
        starButtonHelpView.snp.makeConstraints { (make) in
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(profileImageViewFront.snp.leading)
        }
        
        starButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(starButtonHelpView.snp.centerX)
            make.centerY.equalTo(profileImageViewFront.snp.centerY)
            make.width.height.equalTo(profileImageViewFront.snp.height).multipliedBy(0.4)
        }
        
        let chatButtonHelpView = UIView()
        self.addSubview(chatButtonHelpView)
        
        chatButtonHelpView.snp.makeConstraints { (make) in
            make.leading.equalTo(profileImageViewFront.snp.trailing)
            make.trailing.equalTo(self.snp.trailing)
        }
        
        chatButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(chatButtonHelpView.snp.centerX)
            make.centerY.equalTo(profileImageViewFront.snp.centerY)
            make.width.height.equalTo(profileImageViewFront.snp.height).multipliedBy(0.4)
        }
    }
    
    
    // MARK: Actions
    
    func starPessed() {
        self.delegate?.starButtonPressed()
    }
}

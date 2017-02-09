//
//  UserProfileInfoView.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 1/30/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SnapKit
import Jelly

@objc protocol UserProfileInfoViewDelegate: class {
    func imageTapped()
    
    @objc optional func sendMessage()
}

class UserProfileInfoView: UIView {
    
    weak var delegate: UserProfileInfoViewDelegate?
    
    let userImagePercentOfWidth: CGFloat = 0.4
    
    //MARK: Vars

    let userNameLabel : UILabel = {
        let myVar = UILabel()
        myVar.backgroundColor = UIColor.red
        myVar.textAlignment = .center
        myVar.text = NSLocalizedString("authenticateduservc.username.label", comment: "")
        myVar.layer.cornerRadius = cornerRadius
        return myVar
    }()
    
    let userCountryLabel : UILabel = {
        let myVar = UILabel()
        myVar.backgroundColor = UIColor.red
        myVar.textAlignment = .center
        myVar.text = NSLocalizedString("authenticateduservc.country.label", comment: "")
        myVar.layer.cornerRadius = cornerRadius
        return myVar
    }()
    
    lazy var sendMessageButton : UIButton = {
        let myVar = UIButton(type: .system)
        myVar.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        myVar.backgroundColor = UIColor.red
        myVar.setTitle( "Send Message" , for: .normal)
        return myVar
    }()
    
    lazy var userImageView : UIImageView = {
        let myVar = UIImageView()
        myVar.isUserInteractionEnabled = true
        myVar.image = UIImage.init(named: "image_placeholder")
        myVar.contentMode = .scaleAspectFill
        myVar.layer.borderColor = UIColor.orange.cgColor
        myVar.layer.borderWidth = 1.0
        
        myVar.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
        
        //myVar.addGestureRecognizer(self.tapGesture)
        return myVar
    }()
        
    override func layoutSubviews() {
        let width = self.frame.size.width * userImagePercentOfWidth
        userImageView.layer.cornerRadius = width / 2
        userImageView.clipsToBounds = true
        userImageView.layer.masksToBounds = true
    
    }
    
    
    //MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        
        self.addSubviews([userImageView, userNameLabel, userCountryLabel, sendMessageButton])
        self.sendMessageButton.isHidden = true

        self.setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        
        userImageView.snp.remakeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(20)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(self.snp.width).multipliedBy(userImagePercentOfWidth)
            make.height.equalTo(self.snp.width).multipliedBy(userImagePercentOfWidth)
        }
        
        userNameLabel.snp.remakeConstraints { (make) in
            make.top.equalTo(userImageView.snp.bottom).offset(5)
            make.width.equalTo(self.snp.width).multipliedBy(0.6)
            make.height.equalTo(self.snp.height).multipliedBy(0.1)
            make.centerX.equalTo(userImageView.snp.centerX)
        }
        
        userCountryLabel.snp.remakeConstraints { (make) in
            make.top.equalTo(userNameLabel.snp.bottom).offset(5)
            make.width.equalTo(self.snp.width).multipliedBy(0.6)
            make.height.equalTo(self.snp.height).multipliedBy(0.1)
            make.centerX.equalTo(userImageView.snp.centerX)
        }
        
        sendMessageButton.snp.remakeConstraints { (make) in
            make.top.equalTo(userCountryLabel.snp.bottom).offset(5)
            make.width.equalTo(self.snp.width).multipliedBy(0.6)
            make.height.equalTo(self.snp.height).multipliedBy(0.1)
            make.centerX.equalTo(userImageView.snp.centerX)
        }
    }
    
    // MARK: Actions
    
    @objc private func imageTapped() {
        self.delegate?.imageTapped()
    }
    
    @objc private func sendMessage() {
        self.delegate?.sendMessage!()
    }
    
}

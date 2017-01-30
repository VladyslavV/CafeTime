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

protocol UserProfileInfoViewDelegate: class {
    func imageTapped()
}

class UserProfileInfoView: UIView, UIGestureRecognizerDelegate {
    
    weak var delegate: UserProfileInfoViewDelegate?
    
    let userImagePercentOfWidth: CGFloat = 0.4
    
    lazy var tapGesture: UITapGestureRecognizer = {
        let myVar = UITapGestureRecognizer()
        myVar.delegate = self
        myVar.addTarget(self, action: #selector(imageTapped(_ :)))
        return myVar
    }()
    
    //MARK: Vars
    lazy var userImageView : UIImageView = {
        let myVar = UIImageView()
        myVar.isUserInteractionEnabled = true
        myVar.image = UIImage.init(named: "image_placeholder")
        myVar.contentMode = .scaleAspectFit
        myVar.layer.borderColor = UIColor.orange.cgColor
        myVar.layer.borderWidth = 1.0
        myVar.addGestureRecognizer(self.tapGesture)
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
        
        self.addSubviews([userImageView])

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
    }
    
    // MARK: Actions
    
    @objc private func imageTapped(_ tap: UITapGestureRecognizer) {
        self.delegate?.imageTapped()
    }
    
}

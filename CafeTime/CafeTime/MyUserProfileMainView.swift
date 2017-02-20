//
//  MyUserProfileMainView.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/17/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SnapKit

class MyUserProfileMainView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.lightGray
        self.addSubviews([myUserProfileView])
        self.setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Vars
    
    let myUserProfileView: MyUserProfileView = {
        let myVar = MyUserProfileView()
        return myVar
    }()
    
    // MARK: Set Up
    
    private func setUp() {
        
        myUserProfileView.profileImageViewFront.image = UIImage.init(named: "image")
        myUserProfileView.profileImageViewBackground.image = UIImage.init(named: "image")

        myUserProfileView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(self)
            make.bottom.equalTo(self.snp.centerY)
        }
        
    }

}

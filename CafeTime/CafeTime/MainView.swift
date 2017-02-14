//
//  MainView.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/11/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SnapKit

class MainView: UIView {
    
    let userProfileView : UserProfileView = {
        
        let myVar = UserProfileView()
        return myVar
    }()
    
    let userMenuOptionsView : UserMenuOptionsView = {
        let myVar = UserMenuOptionsView()
        return myVar
    }()
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.addSubviews([userProfileView, userMenuOptionsView])
        self.setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func setUp() {
        
        userProfileView.snp.remakeConstraints { (make) in
            make.leading.trailing.top.equalTo(self)
            make.height.equalTo(self.snp.height).multipliedBy(0.3)
        }
        
        userMenuOptionsView.snp.makeConstraints { (make) in
            make.top.equalTo(userProfileView.snp.bottom)
            make.leading.trailing.bottom.equalTo(self)
        }
    }
    
}

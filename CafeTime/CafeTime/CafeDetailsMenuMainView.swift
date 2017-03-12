//
//  CafeDetailsMenuMainView.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 3/5/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit

class CafeDetailsMenuMainView: UIView {

    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Vars
    
    
    
    // MARK: Set Up

    private func setUp() {
        
        self.backgroundColor = UIColor.red
    }
    
}

//
//  BookHeaderView.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 3/21/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SnapKit

class BookSectionHeaderView: UIView {

    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Colors.primaryGray  
            self.addSubview(titleLabel)
        self.setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Vars
    
    var titleLabel: UILabel = {
        let myVar = UILabel()
        myVar.textAlignment = NSTextAlignment.center
        
        return myVar
    }()
    
    
    // MARK: Set Up
    private func setUp() {
        
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
    }
    
}

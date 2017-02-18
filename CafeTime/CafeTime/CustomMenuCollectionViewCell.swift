//
//  CustomMenuCollectionViewCell.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/17/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SnapKit

class CustomMenuCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.blue
        self.addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Vars
    
    let titleLabel: UILabel = {
        let myVar = UILabel()
        myVar.font = UIFont.systemFont(ofSize: 14)
        myVar.textAlignment = NSTextAlignment.center
        myVar.text = "Title"
        return myVar
    }()
    
    private func setUp() {
        titleLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(self)
            make.height.equalTo(self.snp.height).multipliedBy(0.7)
            make.centerY.equalTo(self.snp.centerY)
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setUp()
    }
    
    
    
    
}

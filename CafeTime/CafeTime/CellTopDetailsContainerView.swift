//
//  CellMainContainerView.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/16/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit

class CellTopDetailsContainerView: ReusableCellContainerView {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviews([discountLabel, likeLabel])
        self.setUp()
       // titleLabel.backgroundColor = UIColor.green
       // detailLabel.backgroundColor = UIColor.red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: VARS
    
    var likeImageView: UIImageView {
        return rightImageView
    }
    
    let likeLabel: UILabel = {
        let myVar = UILabel()
        myVar.adjustsFontSizeToFitWidth = true
        myVar.font = UIFont.systemFont(ofSize: 12)
        myVar.text = "155"
        return myVar
    }()
    
    let discountLabel: UILabel = {
        let myVar = UILabel()
        return myVar
    }()
    
    
    // MARK: Constraints
    
    private func setUp() {
        myImageView.image = UIImage(named: "sandwich")
        myImageView.contentMode = .scaleToFill  
        rightImageView.image = UIImage(named: "heart")
        
        rightImageView.snp.remakeConstraints { (make) in
            make.centerY.equalTo(myImageView.snp.centerY)
            make.width.height.equalTo(self.snp.height).multipliedBy(0.2)
            make.trailing.equalTo(self.snp.trailing).offset(-20)
        }
        
        likeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(rightImageView.snp.bottom).offset(3)
            make.width.equalTo(rightImageView.snp.width)
            make.centerX.equalTo(rightImageView.snp.centerX)
        }

    }
}

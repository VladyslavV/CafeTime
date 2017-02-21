//
//  WhiteCellView.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/17/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SnapKit

class ReusableCellContainerView: ReusableEmtpyCellContainer {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.addSubviews([myImageView, titleLabel, detailLabel, rightImageView])
        self.setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Vars
    
    let myImageView: UIImageView = {
        let myVar = UIImageView()
        myVar.backgroundColor = UIColor.green
        myVar.clipsToBounds = true
        myVar.contentMode = .scaleToFill
        return myVar
    }()
    
    let titleLabel: UILabel = {
        let myVar = UILabel()
        myVar.backgroundColor = UIColor.green
        myVar.adjustsFontSizeToFitWidth = true
        myVar.numberOfLines = 0
        return myVar
    }()
    
    let detailLabel: UILabel = {
        let myVar = UILabel()
        myVar.backgroundColor = UIColor.green
        myVar.font = UIFont.systemFont(ofSize: 14)
        myVar.numberOfLines = 0
        return myVar
    }()
    
    let rightImageView: UIImageView = {
        let myVar = UIImageView()
        myVar.backgroundColor = UIColor.green
        myVar.clipsToBounds = true
        myVar.contentMode = .scaleToFill
        return myVar
    }()
    
    
    // MARK: Set UP
    
    private func setUp() {
        
        myImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(self.snp.leading).offset(10)
            make.height.width.equalTo(self.snp.height).multipliedBy(0.7)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        rightImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(myImageView.snp.centerY)
            make.width.height.equalTo(self.snp.height).multipliedBy(0.5)
            make.trailing.equalTo(self.snp.trailing).offset(-20)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(myImageView.snp.top)
            make.height.equalTo(myImageView.snp.height).multipliedBy(0.25)
            make.leading.equalTo(myImageView.snp.trailing).offset(10)
        }
        
        detailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.trailing.equalTo(rightImageView.snp.leading).offset(-10)
            make.leading.equalTo(myImageView.snp.trailing).offset(10)
            make.bottom.lessThanOrEqualTo(myImageView.snp.bottom)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.width / 27
        myImageView.layer.cornerRadius = myImageView.frame.size.width / 2
    }
}

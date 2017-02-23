//
//  UserOptionsCell.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/12/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SnapKit

class UserMenuOptionsCell: UITableViewCell {
    
    let optionImageView: UIImageView = {
        let myVar = UIImageView()
        myVar.contentMode = .scaleToFill
        return myVar
    }()
    
    let optionTextLabel: UILabel = {
        let myVar = UILabel()
        myVar.font = UIFont.systemFont(ofSize: 20)
        return myVar
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubviews([optionImageView, optionTextLabel])
        self.setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        self.selectionStyle = .gray
        
        self.contentView.snp.remakeConstraints { (make) in
            make.height.equalTo(Utils.shared.screenSize().height * 0.15)
            make.leading.trailing.equalTo(self)
            make.top.equalTo(self.snp.top).offset(10)
            make.bottom.equalTo(self.snp.bottom).offset(-10)
        }
        
        optionImageView.snp.remakeConstraints { (make) in
            make.width.height.equalTo(self.snp.height).multipliedBy(0.7)
            make.leading.equalTo(self.snp.leading).offset(20)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        optionTextLabel.snp.remakeConstraints { (make) in
            make.leading.equalTo(optionImageView.snp.trailing).offset(10)
            make.centerY.equalTo(optionImageView.snp.centerY)
            make.height.equalTo(optionImageView.snp.height).multipliedBy(0.8)
            make.trailing.lessThanOrEqualTo(self.snp.trailing).offset(-5)
        }
    }
}

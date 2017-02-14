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
        self.addSubviews([optionImageView, optionTextLabel])
        self.setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        self.selectionStyle = .gray

        optionImageView.snp.remakeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.leading.equalTo(self.snp.leading).offset(20)
            make.height.width.equalTo(self.snp.height).multipliedBy(0.7)
        }
        
        optionTextLabel.snp.remakeConstraints { (make) in
            make.leading.equalTo(optionImageView.snp.trailing).offset(10)
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(self.snp.height).multipliedBy(0.9)
            make.trailing.equalTo(self.snp.trailing)
        }

       
    }
}

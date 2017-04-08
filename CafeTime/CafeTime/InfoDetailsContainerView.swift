//
//  InfoDetailsContainerView.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 3/4/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SnapKit


class InfoDetailsContainerView: ReusableEmtpyCellContainer {
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviews([titleLabel, descriptionLabel, separator, stars])
        self.setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Vars
    
    var titleLabel: UILabel = {
        let myVar = UILabel()
        myVar.text = "Restaurant Name"
        myVar.textAlignment = NSTextAlignment.center
        myVar.font = UIFont.systemFont(ofSize: 24)
        myVar.textColor = UIColor.black
        return myVar
    }()
    
    var descriptionLabel: UILabel = {
        let myVar = UILabel()
        myVar.numberOfLines = 0
        myVar.textAlignment = NSTextAlignment.natural
        //myVar.lineBreakMode = NSLineBreakMode.byTruncatingTail
        myVar.text = "My requirement is that I need to display text in label in such a way that if the length of text is too big to accommodate in one line, i need to truncate it at the end in such a way that only the last few characters(usually a"
        
        myVar.font = UIFont.systemFont(ofSize: 12)
        myVar.textColor = UIColor.black
        return myVar
    }()
    
    private var stars: UIImageView = {
        let myVar = UIImageView()
        myVar.backgroundColor = UIColor.green
        return myVar
    }()
    
    private var separator = Separator()
    
    // MARK: Set Up
    
    private func setUp() {
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(10)
            make.centerX.equalTo(self.snp.centerX).priority(750)
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(self.snp.height).multipliedBy(0.2)
        }
        
        separator.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.width.equalTo(titleLabel.snp.width)
            make.height.equalTo(self.snp.height).multipliedBy(0.03)
            make.centerX.equalTo(self.snp.centerX).priority(250)
        }
        
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(separator.snp.bottom).offset(10)
            make.width.equalTo(titleLabel.snp.width)
            make.centerX.equalTo(self.snp.centerX).priority(750)
            make.bottom.lessThanOrEqualTo(stars.snp.top).offset(-10)
        }
        
        stars.backgroundColor = UIColor.green
        stars.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.snp.bottom).offset(-20)
            make.centerX.equalTo(self.snp.centerX).priority(750)
            make.height.equalTo(self.snp.height).multipliedBy(0.1)
            make.width.equalTo(self.snp.width).multipliedBy(0.6)
        }
    }
}




private class Separator: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviews([leftLineView, rightLineView, greenCircleSeparator])
        self.setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var leftLineView: UIView = {
        let myVar = UIView()
        myVar.backgroundColor = UIColor.black
        return myVar
    }()
    
    private var rightLineView: UIView = {
        let myVar = UIView()
        myVar.backgroundColor = UIColor.black
        return myVar
    }()
    
    private var greenCircleSeparator: UIView = {
        let myVar = UIView()
        myVar.backgroundColor = UIColor.green
        return myVar
    }()
    
    private func setUp() {
        
        greenCircleSeparator.snp.makeConstraints { (make) in
            make.height.width.equalTo(self.snp.height)
            make.center.equalTo(self.snp.center).priority(750)
        }
        
        leftLineView.snp.makeConstraints { (make) in
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(greenCircleSeparator.snp.leading).offset(-5).priority(750)
            make.height.equalTo(self.snp.height).multipliedBy(0.2)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        rightLineView.snp.makeConstraints { (make) in
            make.trailing.equalTo(self.snp.trailing)
            make.leading.equalTo(greenCircleSeparator.snp.trailing).offset(5).priority(750)
            make.height.equalTo(self.snp.height).multipliedBy(0.2)
            make.centerY.equalTo(self.snp.centerY)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        greenCircleSeparator.layer.cornerRadius = greenCircleSeparator.frame.width / 2
    }
    
}


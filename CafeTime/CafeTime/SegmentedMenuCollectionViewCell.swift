//
//  CustomMenuCollectionViewCell.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/17/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SnapKit

class SegmentedMenuCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.clear
        self.addSubview(titleLabel)
        self.setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Vars
    
    let titleLabel: UILabel = {
        let myVar = UILabel()
        myVar.font = UIFont.systemFont(ofSize: 14)
        myVar.textColor = UIColor.white
        myVar.textAlignment = NSTextAlignment.center
        myVar.text = "Title"
        return myVar
    }()
    
    private let iconImageView: UIImageView = {
        let myVar = UIImageView()
        myVar.contentMode = .scaleAspectFit
        myVar.tintColor = Colors.primaryGreen
        return myVar
    }()
    
    var iconImage: UIImage? {
        didSet {
            let image = iconImage?.withRenderingMode(.alwaysTemplate)
            iconImageView.image = image
            self.addSubview(iconImageView)
            self.setUpWithImage()
        }
    }
    
    private func setUpWithImage() {
        
        iconImageView.snp.remakeConstraints { (make) in
            make.top.equalTo(self.snp.top)
            make.width.equalTo(self.snp.width).multipliedBy(0.4)
            make.height.equalTo(self.snp.height).multipliedBy(0.5)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        titleLabel.snp.remakeConstraints { (make) in
            make.top.equalTo(iconImageView.snp.bottom).offset(5)
            make.leading.trailing.equalTo(self)
            make.height.equalTo(self.snp.height).multipliedBy(0.3)
        }
    }
    
    private func setUp() {

        titleLabel.snp.remakeConstraints { (make) in
            make.leading.trailing.equalTo(self)
            make.height.equalTo(self.snp.height).multipliedBy(0.7)
            make.centerY.equalTo(self.snp.centerY)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
     //   self.setUp()
    }
}

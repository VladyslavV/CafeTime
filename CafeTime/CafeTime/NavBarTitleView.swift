//
//  NavBarImageView.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/10/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SDWebImage
import SnapKit

class NavBarTitleView: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let containerView = UIView()
    let profileImageView = UIImageView()
    let nameLabel = UILabel()

    init(withURLString urlString: String, name: String) {
        super.init(frame: CGRect(x: 0, y:0, width: 100, height: 40))
        self.addSubview(containerView)
        containerView.addSubviews([profileImageView, nameLabel])
        
        nameLabel.text = name
        profileImageView.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage.init(named: "image_placeholder"))

        self.setUp()
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    func setUp() {
        self.frame = CGRect(x: 0, y:0, width: 100, height: 40)
        
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true

        profileImageView.snp.remakeConstraints { (make) in
            make.centerY.equalTo(containerView.snp.centerY)
            make.leading.equalTo(containerView.snp.leading)
            make.width.height.equalTo(self.snp.height).multipliedBy(0.9)
        }
        
        nameLabel.snp.remakeConstraints { (make) in
            make.leading.equalTo(profileImageView.snp.trailing).offset(2)
            make.trailing.equalTo(containerView.snp.trailing)
            make.centerY.equalTo(containerView.snp.centerY)
            make.height.equalTo(profileImageView.snp.height)
        }
        
        containerView.snp.remakeConstraints { (make) in
            make.center.equalTo(self.snp.center)
        }
    }
    
    override func layoutSubviews() {
        profileImageView.layer.cornerRadius = profileImageView.bounds.size.width / 2
    }
}

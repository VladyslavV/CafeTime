//
//  UserProfileView.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/11/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class UserProfileView: UIView {

    let profileImageViewBackground : UIImageView = {
        let myVar = UIImageView()
        myVar.image = UIImage.init(named: "image")        
        return myVar
    }()
    
    let profileImageViewFront: UIImageView = {
        let myVar = UIImageView()
        myVar.clipsToBounds = true
        myVar.contentMode = .scaleAspectFill
        myVar.image = UIImage.init(named: "image")
        return myVar
    }()
    
    let nameLabel: UILabel = {
        let myVar = UILabel()
        myVar.text = "Name_Placeholder"
        myVar.textColor = UIColor.white
        myVar.textAlignment = .center
        return myVar
    }()
    
    private let blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.regular)
        let myVar = UIVisualEffectView(effect: blurEffect)
        return myVar
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviews([profileImageViewBackground, profileImageViewFront, nameLabel])
        self.profileImageViewBackground.addSubview(blurView)
        self.setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(withImage image: UIImage) {
        self.init()
        profileImageViewFront.image = image
        profileImageViewBackground.image = image
    }
    
    convenience init(withImageURLString urlString: String) {
        self.init()
        profileImageViewFront.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage.init(named: "image_placeholder"))
        profileImageViewBackground.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage.init(named: "image_placeholder"))
    }
    
    private func setUp() {
        
        profileImageViewBackground.snp.remakeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        blurView.snp.remakeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        profileImageViewFront.snp.remakeConstraints { (make) in
            make.center.equalTo(profileImageViewBackground.snp.center)
            make.width.height.equalTo(self.snp.height).multipliedBy(0.5)
        }
        
        nameLabel.snp.remakeConstraints { (make) in
            make.centerX.equalTo(profileImageViewFront.snp.centerX)
            make.leading.trailing.equalTo(self)
            make.top.equalTo(profileImageViewFront.snp.bottom).offset(10)
            make.bottom.equalTo(self.snp.bottom).offset(-10)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageViewFront.layer.cornerRadius = profileImageViewFront.frame.size.width / 2
    }

}

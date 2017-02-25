//
//  DetailsPageTopContainerView.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/20/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SnapKit

class DetailsPageTopContainerView: ReusableEmtpyCellContainer {

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviews([helpViewTopLeft, helpViewTopRight, helpViewBtmLeft, helpViewBtmRight, favoriteContainerView, followersContainerView, likesContainerView, commentsContainerView])
        
        self.setUpConstraints()
        
        self.setUpValues(image: nil,  descriptionText: "Favorites", forContainer: favoriteContainerView)
        
         self.setUpValues(image: nil, descriptionText: "Followers", forContainer: followersContainerView)
        
         self.setUpValues(image: nil, descriptionText: "Likes", forContainer: likesContainerView)
        
         self.setUpValues(image: nil, descriptionText: "Comments", forContainer: commentsContainerView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Vars
    
    // MARK: Public
    
    var favorites: Int = 0 {
        didSet {
            let numSeleceted = favoriteContainerView.midView as! UILabel
            numSeleceted.text = String(favorites)
        }
    }
    
    var followers: Int = 0 {
        didSet {
            let numSeleceted = followersContainerView.midView as! UILabel
            numSeleceted.text = String(followers)
        }
    }
    
    var likes: Int = 0 {
        didSet {
            let numSeleceted = likesContainerView.midView as! UILabel
            numSeleceted.text = String(likes)
        }
    }
    
    var comments: Int = 0 {
        didSet {
            let numSeleceted = commentsContainerView.midView as! UILabel
            numSeleceted.text = String(comments)
        }
    }

    
    // MARK: Private

    private let helpViewTopLeft = UIView()
    private let helpViewBtmLeft = UIView()
    private let helpViewTopRight = UIView()
    private let helpViewBtmRight = UIView()

    
    private let favoriteContainerView = Reusable_LeftView_MidView_RightView_Container(view1: UIImageView(), view2: UILabel(), view3: UILabel())
    
    private let followersContainerView =  Reusable_LeftView_MidView_RightView_Container(view1: UIImageView(), view2: UILabel(), view3: UILabel())
    
    private let likesContainerView =  Reusable_LeftView_MidView_RightView_Container(view1: UIImageView(), view2: UILabel(), view3: UILabel())
    
    private let commentsContainerView =  Reusable_LeftView_MidView_RightView_Container(view1: UIImageView(), view2: UILabel(), view3: UILabel())

    // MARK: Set Up Values 
    
    private func setUpValues(image: UIImage?, descriptionText: String?, forContainer container: Reusable_LeftView_MidView_RightView_Container) {
        
        let imageview = container.leftView as! UIImageView
        imageview.backgroundColor = UIColor.green
        imageview.image = image
        
        let numSeleceted = container.midView as! UILabel
        numSeleceted.text = "55"

        let descriptionLabel = container.rightView as! UILabel
        descriptionLabel.text = descriptionText
        descriptionLabel.backgroundColor = UIColor.green
        descriptionLabel.adjustsFontSizeToFitWidth = true
    }
    
    
    // MARK: Set Up Constraints
    
    private func setUpConstraints() {
        
        helpViewTopLeft.snp.makeConstraints { (make) in
            make.width.equalTo(self.snp.width).multipliedBy(0.5)
            make.height.equalTo(self.snp.height).multipliedBy(0.5)
            make.top.leading.equalTo(self)
        }

        helpViewBtmLeft.snp.makeConstraints { (make) in
            make.width.equalTo(self.snp.width).multipliedBy(0.5)
            make.height.equalTo(self.snp.height).multipliedBy(0.5)
            make.bottom.leading.equalTo(self)
        }

        helpViewTopRight.snp.makeConstraints { (make) in
            make.width.equalTo(self.snp.width).multipliedBy(0.5)
            make.height.equalTo(self.snp.height).multipliedBy(0.5)
            make.top.trailing.equalTo(self)
        }

        helpViewBtmRight.snp.makeConstraints { (make) in
            make.width.equalTo(self.snp.width).multipliedBy(0.5)
            make.height.equalTo(self.snp.height).multipliedBy(0.5)
            make.bottom.trailing.equalTo(self)
        }
        
        // Main
        
        favoriteContainerView.snp.makeConstraints { (make) in
            make.width.equalTo(helpViewTopLeft.snp.width).multipliedBy(0.9)
            make.height.equalTo(helpViewTopLeft.snp.height).multipliedBy(0.8)
            make.center.equalTo(helpViewTopLeft)
        }
        
        followersContainerView.snp.makeConstraints { (make) in
            make.width.equalTo(helpViewTopLeft.snp.width).multipliedBy(0.9)
            make.height.equalTo(helpViewTopLeft.snp.height).multipliedBy(0.8)
            make.center.equalTo(helpViewTopRight)
        }
        
        likesContainerView.snp.makeConstraints { (make) in
            make.width.equalTo(helpViewTopLeft.snp.width).multipliedBy(0.9)
            make.height.equalTo(helpViewTopLeft.snp.height).multipliedBy(0.8)
            make.center.equalTo(helpViewBtmLeft)
        }
        
        commentsContainerView.snp.makeConstraints { (make) in
            make.width.equalTo(helpViewTopLeft.snp.width).multipliedBy(0.9)
            make.height.equalTo(helpViewTopLeft.snp.height).multipliedBy(0.8)
            make.center.equalTo(helpViewBtmRight)
        }
    }
}

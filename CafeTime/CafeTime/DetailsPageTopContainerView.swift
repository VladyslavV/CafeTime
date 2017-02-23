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
        
        self.setUpValues(image: nil, timesSelectedText: "57", descriptionText: "Description", forContainer: favoriteContainerView)
        
         self.setUpValues(image: nil, timesSelectedText: "57", descriptionText: "Description", forContainer: followersContainerView)
        
         self.setUpValues(image: nil, timesSelectedText: "57", descriptionText: "Description", forContainer: likesContainerView)
        
         self.setUpValues(image: nil, timesSelectedText: "57", descriptionText: "Description", forContainer: commentsContainerView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Vars
    
        // MARK: Public

    func updateValuesForFavoriteContainerView(image: UIImage?, timesSelectedText: String, descriptionText: String) {
        self.setUpValues(image: image, timesSelectedText: timesSelectedText, descriptionText: descriptionText, forContainer: self.favoriteContainerView)
    }
    
    func updateValuesForFollowersContainerView(image: UIImage?, timesSelectedText: String, descriptionText: String) {
        self.setUpValues(image: image, timesSelectedText: timesSelectedText, descriptionText: descriptionText, forContainer: self.followersContainerView)
    }
    
    func updateValuesForLikesContainerView(image: UIImage?, timesSelectedText: String, descriptionText: String) {
        self.setUpValues(image: image, timesSelectedText: timesSelectedText, descriptionText: descriptionText, forContainer: self.likesContainerView)
    }
    
    func updateValuesForCommentsContainerView(image: UIImage?, timesSelectedText: String, descriptionText: String) {
        self.setUpValues(image: image, timesSelectedText: timesSelectedText, descriptionText: descriptionText, forContainer: self.commentsContainerView)
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
    
    private func setUpValues(image: UIImage?, timesSelectedText: String, descriptionText: String, forContainer container: Reusable_LeftView_MidView_RightView_Container) {
        
        let imageview = container.leftView as! UIImageView
        imageview.backgroundColor = UIColor.green
        imageview.image = image
        
        let timesSelectedLabel = container.midView as! UILabel
        timesSelectedLabel.backgroundColor = UIColor.green
        timesSelectedLabel.text = timesSelectedText
        
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

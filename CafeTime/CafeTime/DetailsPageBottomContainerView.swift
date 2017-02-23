//
//  DetailsPageBottomContainerView.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/21/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit

class DetailsPageBottomContainerView: ReusableEmtpyCellContainer {
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubviews([nameContainerView, emailContainerView, locationContainerView])
        
        self.setUpConstraints()
        
        self.setUpValues(image: nil, email: "Email placeholder", editButton: nil, forContainer: nameContainerView)
        
        self.setUpValues(image: nil, email: "Email placeholder", editButton: nil, forContainer: emailContainerView)
        
        self.setUpValues(image: nil, email: "Email placeholder", editButton: nil, forContainer: locationContainerView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Vars
    
    private let nameContainerView = Reusable_LeftView_MidView_RightView_Container(view1: UIImageView(), view2: UILabel(), view3: UIButton())
    private let emailContainerView = Reusable_LeftView_MidView_RightView_Container(view1: UIImageView(), view2: UILabel(), view3: UIButton())
    private let locationContainerView = Reusable_LeftView_MidView_RightView_Container(view1: UIImageView(), view2: UILabel(), view3: UIButton())
    
    
    // MARK: Set Up Values
    
    private func setUpValues(image: UIImage?, email: String, editButton: UIImage?, forContainer container: Reusable_LeftView_MidView_RightView_Container) {
        
        let imageview = container.leftView as! UIImageView
        imageview.backgroundColor = UIColor.red
        
        let emailLabel = container.midView as! UILabel
        emailLabel.text = email
        
        let editButton = container.rightView as! UIButton
        editButton.backgroundColor = UIColor.red
    }
    
    
    
    // MARK: Set Up Constraints
    
    private func setUpConstraints() {
                
        nameContainerView.snp.makeConstraints { (make) in
            make.height.equalTo(self.snp.height).multipliedBy(0.3)
            make.leading.trailing.equalTo(self)
            make.top.equalTo(self.snp.top)
        }
        
        emailContainerView.snp.makeConstraints { (make) in
            make.height.equalTo(self.snp.height).multipliedBy(0.3)
            make.leading.trailing.equalTo(self)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        locationContainerView.snp.makeConstraints { (make) in
            make.height.equalTo(self.snp.height).multipliedBy(0.3)
            make.leading.trailing.equalTo(self)
            make.bottom.equalTo(self.snp.bottom)
        }
        
        self.remakeConstraintsForViews(inContainer: nameContainerView)
        self.remakeConstraintsForViews(inContainer: emailContainerView)
        self.remakeConstraintsForViews(inContainer: locationContainerView)
        
    }
    
    private func remakeConstraintsForViews(inContainer container: Reusable_LeftView_MidView_RightView_Container) {
        
        
        container.leftView?.snp.remakeConstraints{ (make) in
            make.leading.equalTo(container.snp.leading).offset(10)
            make.centerY.equalTo(container.snp.centerY)
            make.height.width.equalTo(container.snp.height).multipliedBy(0.7)
        }
        
        container.midView?.snp.remakeConstraints { (make) in
            make.leading.equalTo((container.leftView?.snp.trailing)!).offset(10)
            make.height.equalTo(container.snp.height).multipliedBy(0.7)
            make.centerY.equalTo(container.snp.centerY)
            make.width.lessThanOrEqualTo(container.snp.width).multipliedBy(0.6)
        }
        
        container.rightView?.snp.remakeConstraints({ (make) in
            make.trailing.equalTo(container.snp.trailing).offset(-5)
            make.centerY.equalTo(container.snp.centerY)
            make.height.width.equalTo(container.snp.height).multipliedBy(0.7)
        })
        
        
    }
}

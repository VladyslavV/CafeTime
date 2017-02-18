//
//  UserProfileVC.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/8/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import Jelly

class OldUserProfileVC: UIViewController {
    
    internal var jellyAnimator: JellyAnimator?
    
    internal let customer: Customer!
    
    private lazy var mainView: UserProfileMainView = {
        let localUser = Remote.anyAccess().auth.isLocalUser(withUID: self.customer.uid)
        let myVar = UserProfileMainView(forLocalUser: localUser)
        return myVar
    }()
    
    internal lazy var userProfileView: UserProfileInfoView = {
        let myVar = self.mainView.userProfileInfoView
        myVar.delegate = self
        return myVar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
    }
    
    private func setUp() {
        self.view.addSubview(mainView)
        
        mainView.snp.remakeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
        }
    }
    
    init(withCustomer customer: Customer) {
        self.customer = customer
        super.init(nibName: nil, bundle: nil)
        self.showUserProfile()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showUserProfile() {
        
        self.navigationItem.title = customer.name
        self.userProfileView.userNameLabel.text = customer.name
        self.userProfileView.userCountryLabel.text = customer.country
        self.userProfileView.userImageView.sd_setImage(with: URL(string: customer.profileImageURL), placeholderImage: UIImage.init(named: "image_placeholder"))
        
        
        Remote.anyAccess().customer.fetchCustomer(withUID: customer.uid) { [weak self] (customer) in
            
            guard let weakSelf = self else { return }
            
            weakSelf.navigationItem.title = customer?.name
            weakSelf.userProfileView.userNameLabel.text = customer?.name
            weakSelf.userProfileView.userCountryLabel.text = customer?.country
            if let imageURL = customer?.profileImageURL {
                weakSelf.userProfileView.userImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage.init(named: "image_placeholder"))
            }
        }
    }
}


extension OldUserProfileVC: UserProfileInfoViewDelegate {
    
    //MARK: User Profile View Delegate
    
    func imageTapped() {
        guard let image = userProfileView.userImageView.image else { return }
        
        let imageVC = ImageVC(withImage: image)
        
        let customPresentation = JellySlideInPresentation(dismissCurve: .linear,
                                                          presentationCurve: .linear,
                                                          cornerRadius: 15,
                                                          backgroundStyle: .blur(effectStyle: .light),
                                                          jellyness: .jellier,
                                                          duration: .normal,
                                                          directionShow: .top,
                                                          directionDismiss: .top,
                                                          widthForViewController: .fullscreen,
                                                          heightForViewController: .fullscreen ,
                                                          horizontalAlignment: .center,
                                                          verticalAlignment: .center,
                                                          marginGuards: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5),
                                                          corners: .allCorners)
        
        self.jellyAnimator = JellyAnimator(presentation:customPresentation)
        self.jellyAnimator?.prepare(viewController: imageVC)
        self.present(imageVC, animated: true, completion: nil)
    }
    
    func sendMessage() {
        self.navigationController?.pushViewController(ChatVC(customer: self.customer), animated: true)
    }
}



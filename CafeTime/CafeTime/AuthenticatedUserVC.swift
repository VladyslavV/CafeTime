//
//  AuthenticatedUserVC.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 1/25/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SnapKit
import FirebaseAuth
import Jelly
import SDWebImage

class AuthenticatedUserVC: UIViewController, AuthenticatedUserMainViewDelegate, UserProfileInfoViewDelegate {
    
    private var jellyAnimator: JellyAnimator?
    
    private lazy var mainView: AuthenticatedUserMainView = {
        let myVar = AuthenticatedUserMainView()
        myVar.delegate = self
        return myVar
    }()
    
    private lazy var userProfileView: UserProfileInfoView = {
        let myVar = self.mainView.userProfileInfoView
        myVar.delegate = self
        return myVar
    }()
    
    private lazy var navBarButtonRight : UIBarButtonItem = {
        let myVar = UIBarButtonItem(image: UIImage.init(named: "editprofilebutton_image"), style: .plain, target: self, action: #selector(AuthenticatedUserVC.editProfile))
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
        
        let tabBarImage = UIImage.init(named: "profile_tabbarimage")
        self.tabBarItem = UITabBarItem(title: NSLocalizedString("authenticateduservc.tabbar.name", comment: ""), image: tabBarImage , selectedImage: tabBarImage)
        
        self.navigationItem.rightBarButtonItem = navBarButtonRight
    }
    
    // update view
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        
        let remoteCustomer = Remote.anyAccess().customer
        remoteCustomer.fetchCurrentCustomer { [weak self] (user) in
            guard let weakSelf = self else { return }
            
            weakSelf.navigationItem.title =  user?.name
            weakSelf.userProfileView.userNameLabel.text = user?.name
            weakSelf.userProfileView.userCountryLabel.text = user?.country
            
            if let imageURLString = user?.profileImageURL {
                weakSelf.userProfileView.userImageView.sd_setImage(with: URL(string: imageURLString), placeholderImage: UIImage.init(named: "image_placeholder"))
            }
        }
    }
    
    //MARK: Main View Delegate
    
    func logOutButtonPressed() {
        self.logOutUser()
    }
    
    func deleteUserButtonPressed() {
        if let remoteCustomer = Remote.onlineAccess()?.customer {
            remoteCustomer.deleteCurrentUser { (error, success) in
                if !success {
                    self.presentAlert(message: error)
                }
                else {
                    self.logOutUser()
                }
            }
        }
    }
    
    // MARK: Private Funcs
    
    private func logOutUser() {
        if let auth = Remote.onlineAccess()?.auth {
            auth.logOutUser()
            self.presentInNav(vcs: [self, LoginVC()])
        }
    }
    
    // MARK: Actions
    
    @objc private func editProfile() {
        self.navigationController?.pushViewController(ChatVC(), animated: true)
    }
    
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
}

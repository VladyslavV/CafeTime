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
import PKHUD

class CurrentUserProfileVC: UIViewController  {
    
    internal var jellyAnimator: JellyAnimator?
    
    private lazy var mainView: UserProfileMainView = {
        let myVar = UserProfileMainView()
        myVar.delegate = self
        return myVar
    }()
    
    internal lazy var userProfileView: UserProfileInfoView = {
        let myVar = self.mainView.userProfileInfoView
        myVar.delegate = self
        return myVar
    }()
    
    private lazy var navBarButtonRight : UIBarButtonItem = {
        let myVar = UIBarButtonItem(image: UIImage.init(named: "editprofilebutton_image"), style: .plain, target: self, action: #selector(CurrentUserProfileVC.editProfile))
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
        self.navigationItem.rightBarButtonItem = navBarButtonRight
    }
    
    //MARK: Init
    
    init() {
        super.init(nibName:nil, bundle:nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("")
    }
    
    // update view
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        self.showCurrentUserProfile()
    }
    
    func showCurrentUserProfile() {
        Remote.anyAccess().customer.fetchCurrentCustomer { [weak self] (customer) in
            guard let weakSelf = self else { return }
            
            weakSelf.navigationItem.title =  customer?.name
            weakSelf.userProfileView.userNameLabel.text = customer?.name
            weakSelf.userProfileView.userCountryLabel.text = customer?.country
            
            if let imageURLString = customer?.profileImageURL {
                weakSelf.userProfileView.userImageView.sd_setImage(with: URL(string: imageURLString), placeholderImage: UIImage.init(named: "image_placeholder"))
            }
        }
    }
    
   
    // MARK: Private Funcs
    
    internal func logOutUser() {
        if let auth = Remote.serverAccess()?.auth {
            auth.logOutUser()
            self.presentInNav(vcs: [self, LoginVC()])
        }
        else {
            self.presentAlert(message: NSLocalizedString("allert.title.no.internet", comment: ""))
        }
    }
    
    // MARK: Actions
    
    @objc private func editProfile() {
        self.navigationController?.pushViewController(ChatVC(), animated: true)
    }
}


extension CurrentUserProfileVC: UserProfileMainViewDelegate {
    
    //MARK: Main View Delegate
    
    func logOutButtonPressed() {
        self.logOutUser()
    }
    
    func deleteUserButtonPressed() {
        
        if let auth = Remote.serverAccess()?.auth {
            
            self.presenetAlertWithCredentialFields { (email, password) in
                HUD.show(.progress)
                
                auth.authenticateUser(email: email, password: password, rememberUser: false, completion: { (error, success) in
                    
                    
                    if success {
                        if let auth = Remote.serverAccess()?.auth {
                            auth.deleteCurrentUser(customer: true) { [weak self] (error, success) in
                                guard let weakSelf = self else { return }
                                if !success {
                                    HUD.flash(.error, onView: self?.view, delay: 0.1, completion: { (end) in
                                        weakSelf.presentAlert(message: error)
                                    })
                                }
                                else {
                                    HUD.flash(.success, delay: 0.4)
                                    weakSelf.logOutUser()
                                }
                            }
                        }
                    }
                    else {
                        HUD.hide()
                        self.presentAlert(message: error)
                    }
                })
            }
        }
        else {
            self.presentAlert(message: NSLocalizedString("allert.title.no.internet", comment: ""))
        }
    }
}

extension CurrentUserProfileVC: UserProfileInfoViewDelegate {
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

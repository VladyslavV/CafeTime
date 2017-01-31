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
import RealmSwift
import RxRealm
import RxSwift

class AuthenticatedUserVC: UIViewController, AuthenticatedUserMainViewDelegate, UserProfileInfoViewDelegate {
    
    private var jellyAnimator: JellyAnimator?
    private let viewModel = AuthenticatedUserViewModel()
    private let mainView = AuthenticatedUserMainView()
    private let authManager = AuthManager.shared
    private var userProfileView: UserProfileInfoView?
    
    var realmUserObserver: Disposable?
    
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
        userProfileView = mainView.userProfileInfoView
        userProfileView?.delegate = self
        
        mainView.delegate = self
        mainView.snp.remakeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
        }
        
        let tabBarImage = UIImage.init(named: "profile_tabbarimage")
        self.tabBarItem = UITabBarItem(title: NSLocalizedString("authenticateduservc.tabbar.name", comment: ""), image: tabBarImage , selectedImage: tabBarImage)
        
        
        self.navigationItem.rightBarButtonItem = navBarButtonRight
        
        
        //Need to work on this still ...
        
//        let realmManager = RealmManager()
//        if let user = realmManager.localUser {
//            realmUserObserver = Observable.from(object: user).subscribe { (event) in
//                self.navigationItem.title =  user.name
//            }
//        }
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        authManager.fetchSelf { [weak self] (user) in
//            guard let weakSelf = self else { return }
//            weakSelf.navigationItem.title =  user.name
//        }
//    }
    
    //MARK: Main View Delegate
    
    func logOutButtonPressed() {
        self.logOutUser()
    }
    
    // MARK: Private Funcs
    
    @objc private func logOutUser() {
        authManager.logOutUser()
        self.presentLoginController()
    }
    
    @objc private func editProfile() {
        print("touched")
    }
    
    private func presentLoginController() {
        let nav = UINavigationController(rootViewController: LoginVC())
        self.present(nav, animated: true, completion: nil)
    }
    
    //MARK: User Profile View Delegate
    
    func imageTapped() {
        guard let image = userProfileView?.userImageView.image else { return }
        
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
    
    //MARK: Remove Observers
    
    deinit {
        realmUserObserver?.dispose()
    }
}

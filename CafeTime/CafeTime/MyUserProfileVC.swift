//
//  MyUserProfile.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/17/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SnapKit

class MyUserProfileVC: BaseVC {
    
    private let detailsPageVC = DetailsPageVC()
    private let favoritesPageVC = FavoritesPageVC()
    private let commentsPagePC = CommentsPageVC()

    private lazy var vcsList: [Any] = {
        let dict = [["Details" : self.detailsPageVC], ["Favorites" : self.favoritesPageVC], ["Comments" : self.commentsPagePC]] as [Any]
        return dict
    }()
    
    private lazy var pagesContainerVC: ReusablePagesVC = {
        let myVar = ReusablePagesVC(vcsList: self.vcsList as! [[String : UIViewController]])
        myVar.titlesFont = UIFont.boldSystemFont(ofSize: 16)
        myVar.sliderHeight = 3
        myVar.menuBarHeight = 40
        return myVar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "My Profile"
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.revealViewController().delegate = self

        self.view.addSubview(mainView)
        self.view.backgroundColor = UIColor.lightGray
        
        self.addChildViewController(pagesContainerVC)
        self.view.addSubview(pagesContainerVC.view)
        pagesContainerVC.didMove(toParentViewController: self)
        self.setUp()
    }
    
    
    // MARK: Vars
    
    internal lazy var mainView: MyUserProfileMainView = {
        let myVar = MyUserProfileMainView()
        myVar.myUserProfileView.delegate = self
        return myVar
    }()
    
    internal var myUserProfileView: MyUserProfileView  {
        return mainView.myUserProfileView
    }
    
    private func setUp() {
        
        pagesContainerVC.view.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalTo(self.view)
            make.height.equalTo(self.view.snp.height).multipliedBy(0.6)
        }
        
        mainView.snp.makeConstraints { (make) -> Void in
            make.top.leading.trailing.bottom.equalTo(self.view)
        }
    }
    
    
    // MARK: Assign Data From Server --- Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        navBar?.transparentNavigationBar()

        Remote.anyAccess().customer.fetchCurrentCustomer { [weak self] (customer) in
            
            guard let weakSelf = self else { return }
            weakSelf.mainView.myUserProfileView.nameLabel.text = customer?.name
            
            // pass info to vc
            weakSelf.detailsPageVC.mainView.btmContainerView.name = customer?.name
            weakSelf.detailsPageVC.mainView.btmContainerView.email = customer?.email

        }
    }
    
}

extension MyUserProfileVC: MyUserProfileViewDelegate {
    
    func starButtonPressed() {
        print("star")
    }
    
}

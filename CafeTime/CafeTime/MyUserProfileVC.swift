//
//  MyUserProfile.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/17/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SnapKit

class MyUserProfileVC: UIViewController {
        
    private let vcsList = [["Details" : DetailsPageVC()], ["Favorites" : FavoritesPageVC()], ["Comments" : CommentsPageVC()]] as [Any]
    
    private lazy var pagesContainerVC: ReusablePagesVC = {
        let myVar = ReusablePagesVC(vcsList: self.vcsList as! [[String : UIViewController]])

        myVar.titlesFont = UIFont.boldSystemFont(ofSize: 16)
        myVar.sliderHeight = 3
        return myVar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        
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
        
        self.navigationItem.title = "My Profile"
        
        pagesContainerVC.view.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalTo(self.view)
            make.top.equalTo(self.view.snp.centerY).offset(-30)
        }
        
        mainView.snp.makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
        }
    }
}

extension MyUserProfileVC: MyUserProfileViewDelegate {
    
    func starButtonPressed() {
        print("star")
    }
    
}

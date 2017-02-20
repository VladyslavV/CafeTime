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
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.view.addSubview(mainView)
        self.setUp()
        
        self.view.backgroundColor = UIColor.lightGray
        
//        let pageMenu = ReusableMenuCollectionView(withTitles: ["Details", "Favorites", "Comments"], andSliderAnimationDuration: 0.75)
//        self.mainView.myUserProfileView.addSubview(pageMenu)
//        
//        pageMenu.snp.makeConstraints { (make) in
//            make.leading.trailing.equalTo(mainView.myUserProfileView)
//            make.bottom.equalTo(mainView.myUserProfileView.snp.bottom).offset(-10)
//            make.height.equalTo(mainView.myUserProfileView.snp.height).multipliedBy(0.2)
//        }

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

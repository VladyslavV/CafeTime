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

        self.view.backgroundColor = UIColor.gray
        
        let pageMenu = ReusableMenuCollectionView(withTitles: ["Details", "Favorites", "Comments"], andSliderAnimationDuration: 0.75)
        self.view.addSubview(pageMenu)
        
        pageMenu.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(self.view)
            make.center.equalTo(self.view.center)
            make.height.equalTo(self.view.snp.height).multipliedBy(0.2)
        }
        
        self.view.addSubview(mainView)
        self.setUp()
    }

    // MARK: Vars
    
    let mainView: MyUserProfileMainView = {
        let myVar = MyUserProfileMainView()
        return myVar
    }()
    
    private func setUp() {
     
        self.navigationItem.title = "My Profile"
        
        mainView.snp.makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
        }
    }
}

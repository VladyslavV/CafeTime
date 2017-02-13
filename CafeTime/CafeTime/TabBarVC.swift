//
//  TabBarVC.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/13/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.setUp()        
    }
    
    private func setUp() {
                
        let profileVC = CurrentUserProfileVC()
        let usersVC = UsersListVC()
        
        
        // create vcs
        let navProfile = UINavigationController(rootViewController: profileVC)
        let navUsers = UINavigationController(rootViewController: usersVC)
                
        let vcs = [navUsers, navProfile]
        
        self.setViewControllers(vcs, animated: true)
    }
    
    deinit {
        print("dealloced \(self)")
    }
}

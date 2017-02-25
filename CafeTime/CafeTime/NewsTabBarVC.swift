//
//  TabBarVC.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/13/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit

class NewsTabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.view.backgroundColor = UIColor.white
        self.setUp()
    }
    
    private func setUp() {
        
        
        let homeTabVC = HomeTabVC()
        let bookTabVC = BookTabVC()
        let searchTabVC = SearchTabVC()
        let favoriteTabVC = FavoriteTabVC()
        
        
        let navHome = UINavigationController(rootViewController: homeTabVC)
        let navBook = UINavigationController(rootViewController: bookTabVC)
        let navSearch = UINavigationController(rootViewController: searchTabVC)
        let navFavorite = UINavigationController(rootViewController: favoriteTabVC)
        
        let vcs = [navHome, navBook, navSearch, navFavorite]
        
        // create vcs
        
        //        let profileVC = CurrentUserProfileVC()
        //        let usersVC = UsersListVC()
        
        //        let navProfile = UINavigationController(rootViewController: profileVC)
        //        let navUsers = UINavigationController(rootViewController: usersVC)
        //
        //        let vcs = [navUsers, navProfile]
        
        self.setViewControllers(vcs, animated: true)
    }
    
    deinit {
        print("dealloced \(self)")
    }
}

//
//  BaseVC.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 3/4/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {
    
    // MARK: Vars
    
    // MARK: Private
    
    internal var shouldDisableUserInteraction: Bool = false {
        didSet {
            if shouldDisableUserInteraction {
                self.tabBarController?.tabBar.isUserInteractionEnabled = false
                navBar?.isUserInteractionEnabled = false
                self.view.isUserInteractionEnabled = false
            }
            else {
                self.tabBarController?.tabBar.isUserInteractionEnabled = true
                navBar?.isUserInteractionEnabled = true
                self.view.isUserInteractionEnabled = true
            }
        }
    }
    
    // MARK: Public
        
    var navBar: UINavigationBar? {
        return self.navigationController?.navigationBar
    }
    
    var tabBar: UITabBar? {
        return self.tabBarController?.tabBar
    }
    
    typealias colors = Colors
    
    // MARK: Funcs
    
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navBar?.setNavBarTitleColor(.white)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.revealViewController().delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.hidesBarsOnSwipe = false
        self.resetNavBar()
    }
}

// nav bar
extension BaseVC {
    
    func resetNavBar() {
        navBar?.resetToDefault()
    }
    
    func setupLeftBackArrow(arrowColor: UIColor)->UIBarButtonItem {
        
        let btnBack = UIButton(type: .custom)
        btnBack.addTarget(self, action: #selector(dismiss as (Void) -> Void), for: UIControlEvents.touchUpInside)
        
        let image = UIImage(named: "leftArrow")
      
        btnBack.setImage(image, for: UIControlState())
        btnBack.imageEdgeInsets = UIEdgeInsetsMake(0, -53, 0, 0)
        btnBack.sizeToFit()
        btnBack.frame.size.width = 60
        
        let backButton: UIBarButtonItem = UIBarButtonItem(customView: btnBack)
        
        self.navigationItem.leftBarButtonItem = backButton
        return backButton
    }

    @objc private func dismiss() {
        _ = self.navigationController?.popViewController(animated: true)
    }
}






//
//  BaseVC.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 3/4/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
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
    
    // MARK: Funcs
    
    
    // MARK: Life Cycle
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.revealViewController().delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.resetNavBar()
    }
}

// nav bar
extension BaseVC {
    
    func setNavBarColor(color: UIColor) {
        navigationController?.navigationBar.barTintColor = UIColor.green
    }
    
    func resetNavBar() {
        navBar?.resetToDefault()
    }
}






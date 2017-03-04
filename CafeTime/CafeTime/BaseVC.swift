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
    
    fileprivate var navBarBackgroundView: UIView?
    
    // MARK: Publick
        
    var navBar: UINavigationBar? {
        return self.navigationController?.navigationBar
    }
    
    // MARK: Funcs
    
    
    // MARK: Life Cycle
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.revealViewController().delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.revealViewController().delegate = nil
        self.resetNavBar()
    }
    
}

// nav bar
extension BaseVC {
    
    func addNavBarBackgroundViewWithColor(color: UIColor) {
        
        let view = UIView()

        view.backgroundColor = color
        navBar?.insertSubview(view, at: 0)
        
        view.snp.makeConstraints { (make) in
            make.top.equalTo((navBar?.snp.top)!).offset(-UIApplication.shared.statusBarFrame.height)
            make.leading.trailing.bottom.equalTo(navBar!)
        }
        
        navBarBackgroundView = view
    }
    
    func resetNavBar() {
        navBar?.resetToDefault()
        if let view = navBarBackgroundView {
            view.snp.removeConstraints()
            view.removeFromSuperview()
        }
    }
    
}






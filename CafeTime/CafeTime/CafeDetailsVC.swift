//
//  CafeDetailsVC.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/27/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SnapKit

class CafeDetailsVC: BaseVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = colors.primaryGray
        self.view.addSubviews([mainView])
        self.setUp()
                
        self.tabBar?.barTintColor = colors.primaryGray
        UITabBar.appearance().barTintColor = colors.primaryGray
        
        _ = self.setupLeftBackArrow(arrowColor: UIColor.white)
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        self.navigationController?.hidesBarsOnSwipe = true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    // MARK: Vars
    private var topImageView: UIImageView = {
        let myVar = UIImageView()
        myVar.image = UIImage(named: "superSandwich")
        myVar.contentMode = .scaleToFill
        return myVar
    }()
    
    fileprivate lazy var mainView: CafeDetailsMainView = {
        let myVar = CafeDetailsMainView()
      // myVar.headerView.menuBar.delegate = self
        return myVar
    }()

    
    // MARK: Set Up

    private func setUp() {
        
        self.navigationItem.title = "Restaurant"
        
        mainView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(self.view)
            make.bottom.equalTo(self.bottomLayoutGuide.snp.top)
        }
    }
        
    // MARK: Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navBar?.transparentNavigationBar()
    }
}


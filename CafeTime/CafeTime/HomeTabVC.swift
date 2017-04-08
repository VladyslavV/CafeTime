//
//  HomeTabVC.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/15/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SnapKit

class HomeTabVC: BaseVC {
    
    fileprivate lazy var mainView: HomeTabMainView = {
        let myVar = HomeTabMainView()
        myVar.delegate = self
        return myVar
    }()
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(mainView)
        self.revealViewController().panGestureRecognizer()
        self.revealViewController().tapGestureRecognizer()
        self.setUp()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navBar?.setNavBarColor(.green)
    }
    
    // MARK: Set UP
    
    private func setUp() {
        self.automaticallyAdjustsScrollViewInsets = false

        let tabBarImage = UIImage.init(named: "users_list_tabbarimage")
        self.tabBarItem = UITabBarItem(title: nil, image: tabBarImage , selectedImage: tabBarImage)
        
        self.navigationItem.title = "News"
        
        mainView.snp.remakeConstraints { (make) -> Void in
            make.leading.trailing.equalTo(self.view)
            make.bottom.equalTo(self.bottomLayoutGuide.snp.top)
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
        }
    }
}

extension HomeTabVC: HomeTabMainViewDelegate {
    func cellTapped(inRow row: Int) {
        self.navigationController?.pushViewController(CafeDetailsVC(), animated: true)
        print(row)
    }
}

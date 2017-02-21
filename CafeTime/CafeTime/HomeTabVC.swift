//
//  HomeTabVC.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/15/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SnapKit

class HomeTabVC: UIViewController {
    
    internal lazy var mainView: HomeTabMainView = {
        let myVar = HomeTabMainView()
        myVar.delegate = self
        return myVar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(mainView)
        self.revealViewController().delegate = self
        self.revealViewController().panGestureRecognizer()
        self.revealViewController().tapGestureRecognizer()
        self.setUp()
    }
    
    private func setUp() {
        self.automaticallyAdjustsScrollViewInsets = false
        
        let tabBarImage = UIImage.init(named: "users_list_tabbarimage")
        self.tabBarItem = UITabBarItem(title: nil, image: tabBarImage , selectedImage: tabBarImage)
        
        self.navigationController?.navigationBar.barTintColor = UIColor.green;
        
        self.navigationItem.title = "News"
        
        mainView.snp.remakeConstraints { (make) -> Void in
            make.leading.trailing.equalTo(self.view)
            make.bottom.equalTo(self.bottomLayoutGuide.snp.top)
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
        }
    }
    
}


extension HomeTabVC: SWRevealViewControllerDelegate {
    
    func revealController(_ revealController: SWRevealViewController!, tapGestureRecognizerShouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer!) -> Bool {
        return true
    }
    
    
    func revealController(_ revealController: SWRevealViewController!, willMoveTo position: FrontViewPosition) {
        switch position {
            
        case FrontViewPosition.right:
            self.mainView.disableTableViewTapRecognizer()
        default:
            self.mainView.enableTableViewTapRecognizer()
        }
    }
    
}

extension HomeTabVC: HomeTabMainViewDelegate {
    
    func cellTapped(inRow row: Int) {
        print(row)
    }
}

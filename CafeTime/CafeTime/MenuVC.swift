//
//  MainVC.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/11/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SnapKit

class MenuVC: UIViewController {
    
    internal var newsTabBarVC: NewsTabBarVC? = nil
    
    private let mainView = MainView()
    internal var previousOptionClicked: UserMenuOptions?
    
    private lazy var userMenuOptionsView: UserMenuOptionsView = {
        let myVar = self.mainView.userMenuOptionsView
        return myVar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(mainView)
        self.newsTabBarVC = self.revealViewController().frontViewController as! NewsTabBarVC?
        self.setUp()
    }
    
    private func setUp() {
        userMenuOptionsView.delegate = self
        mainView.snp.remakeConstraints { (make) -> Void in
            make.leading.top.bottom.equalTo(self.view)
            make.width.equalTo(self.view.snp.width).multipliedBy(0.9)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Remote.anyAccess().customer.fetchCurrentCustomer { [weak self] (customer) in
            guard let weakSelf = self else { return }
    
            weakSelf.mainView.userProfileView.nameLabel.text = customer?.name
            if let imageURLString = customer?.profileImageURL {
                weakSelf.mainView.userProfileView.profileImageViewFront.sd_setImage(with: URL(string: imageURLString), placeholderImage: UIImage.init(named: "image_placeholder"))
                 weakSelf.mainView.userProfileView.profileImageViewBackground.sd_setImage(with: URL(string: imageURLString), placeholderImage: UIImage.init(named: "image_placeholder"))
            }
        }
    }
}

extension MenuVC: UserMenuOptionsDelegate {
    
    func optionClicked(userMenuOptions: UserMenuOptions) {
        
        if self.previousOptionClicked == userMenuOptions {
            self.revealViewController().setFrontViewPosition(.leftSideMost, animated: true)
            return
        }
        
        if userMenuOptions == .news {
            if let tabbarvc = self.newsTabBarVC {
                self.revealViewController().pushFrontViewController(tabbarvc, animated: false)
                self.revealViewController().setFrontViewPosition(.leftSideMost, animated: true)
                return
            }
        }
        
        var vc = UIViewController()
        switch userMenuOptions {
        case .myProfile:
            vc = CustomVC()
            print("myProfile chosen")
        case .settings:
            print("settings chosen")
        case .myComments:
            print("comments chosen")
        case .chat:
            print("chat chosen")
        case .favorite:
            print("favorite chosen")
        case .nearMe:
            print("near me chosen")
        case .myRestaurants:
            print("my restaurants chosen")
        default:
            return
        }
        
        self.revealViewController().pushFrontViewController(vc, animated: false)
        self.revealViewController().setFrontViewPosition(.leftSideMost, animated: true)
        self.previousOptionClicked = userMenuOptions
    }
    
}

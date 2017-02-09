//
//  UsersListVC.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/8/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SnapKit

class UsersListVC: UIViewController {

    private lazy var mainView: UsersListMainView = {
        let myVar = UsersListMainView()
        myVar.delegate = self
        return myVar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
    }

    private func setUp() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(mainView)
        
        let tabBarImage = UIImage.init(named: "users_list_tabbarimage")
        self.tabBarItem = UITabBarItem(title: NSLocalizedString("Users", comment: ""), image: tabBarImage , selectedImage: tabBarImage)
        
        self.navigationItem.title = "Users"

        mainView.snp.remakeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
        }
    }

    // MARK: Fetch Customers 
    
    override func viewWillAppear(_ animated: Bool) {
        Remote.anyAccess().customer.fetchAllCustomers(completion: { [weak self] (customers) in
            
            guard let weakSelf = self else { return }
            
            if let customersArray = customers {
                weakSelf.mainView.customers = customersArray
            }
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Remote.anyAccess().customer.removeCustomersObserver()
    }
}

extension UsersListVC: UsersListMainViewDelegate {
    //MARK: Main View Delegate
    func showProfile(forCustomer customer: Customer) {
        let profileVC = UserProfileVC(withCustomer: customer)
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
}

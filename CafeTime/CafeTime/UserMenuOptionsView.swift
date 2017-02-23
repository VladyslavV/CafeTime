//
//  UserOptionsVC.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/12/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SnapKit

protocol UserMenuOptionsDelegate: class {
    func optionClicked(userMenuOptions: UserMenuOptions)
}

enum UserMenuOptions: String {
    case myProfile = "Profile"
    case settings = "Settings"
    case news = "News"
    case myComments = "My comments"
    case chat = "Chat"
    case favorite = "Favorite"
    case nearMe = "Near Me"
    case myRestaurants = "My Restaurants"
    
    static let allValues = [myProfile, settings, news, myComments, chat, favorite, nearMe, myRestaurants]
    
}


class UserMenuOptionsView: UIView {
    
    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(tableView)
        self.setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Vars
    
    weak var delegate: UserMenuOptionsDelegate?
    
    fileprivate let cellID = "cell"
    private lazy var tableView: UITableView = {
        let myVar = UITableView()
        myVar.register(UserMenuOptionsCell.self, forCellReuseIdentifier: self.cellID)
        myVar.tableFooterView = UIView()
        //  let headerView =  UIView.init(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        //  headerView.backgroundColor = UIColor.red
        //  myVar.tableHeaderView = headerView
        myVar.separatorStyle = .none
        myVar.separatorInset = UIEdgeInsets.zero
        myVar.estimatedRowHeight = 70
        myVar.rowHeight = UITableViewAutomaticDimension
        //  myVar.bounces = false
        //  myVar.rowHeight = UITableViewAutomaticDimension
        //  myVar.estimatedRowHeight = 150
        myVar.delegate = self
        myVar.dataSource = self
        return myVar
    }()
    
    // MARK: Set Up

    private func setUp() {
        tableView.snp.remakeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
}

extension UserMenuOptionsView: UITableViewDelegate, UITableViewDataSource {
    // MARK: Table View Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserMenuOptions.allValues.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellID, for: indexPath) as! UserMenuOptionsCell
        
        cell.optionTextLabel.text = UserMenuOptions.allValues[indexPath.row].rawValue
        cell.optionImageView.image = UIImage.init(named: "image")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.optionClicked(userMenuOptions: UserMenuOptions.allValues[indexPath.row])
    }
    

}

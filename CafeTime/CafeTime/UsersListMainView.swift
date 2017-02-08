
//
//  UsersListMainView.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/8/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SDWebImage

protocol UsersListMainViewDelegate: class {
    func showProfile(forCustomerWithUID uid: String)
}

class UsersListMainView: UIView, UITableViewDelegate , UITableViewDataSource {
    
    weak var delegate: UsersListMainViewDelegate?
    
    var customers : [Customer] = [Customer]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    private lazy var tableView : UITableView = {
        let myVar = UITableView()
        myVar.delegate = self
        myVar.dataSource = self
        myVar.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        myVar.separatorInset = UIEdgeInsets.zero
        myVar.rowHeight = UITableViewAutomaticDimension
        myVar.tableFooterView = UIView()
        myVar.estimatedRowHeight = 200
        myVar.allowsSelection = true
        self.addSubview(myVar)
        return myVar
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        self.setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        tableView.snp.remakeConstraints { (make) -> Void in
            make.self.edges.equalToSuperview()
        }
    }
    
    
    // MARK: Table View Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = customers[indexPath.row].name
        let imageURLString = customers[indexPath.row].profileImageURL
        cell.imageView?.sd_setImage(with: URL(string: imageURLString), placeholderImage: UIImage.init(named: "image_placeholder"))
        
        return cell
    }
    
    
    @objc(tableView:didSelectRowAtIndexPath:) func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        delegate?.showProfile(forCustomerWithUID: customers[indexPath.row].uid)
    }
}

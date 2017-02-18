//
//  HomeTabMainView.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/15/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit

class HomeTabMainView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    internal lazy var tableView: UITableView = {
        let myVar = UITableView()
        myVar.register(HomeTabCell.self, forCellReuseIdentifier: "homeTabCell")
        myVar.tableFooterView = UIView()
        myVar.separatorStyle = .none
        myVar.separatorInset = UIEdgeInsets.zero
        myVar.delegate = self
        myVar.dataSource = self
        return myVar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(tableView)
        self.setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        
        tableView.snp.remakeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    // MARK: TableView Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "homeTabCell", for: indexPath) as! HomeTabCell
        
        //cell.mainContainerView.topContainerView.delegate = self
        
        cell.mainContainerView.topContainerView.titleLabel.text = "Title"
        cell.mainContainerView.topContainerView.detailLabel.text = "Many details will go here including lorem ipsum!!! details will go here including lorem ipsum details will go here including lorem ipsum will go here including lorem ipsum will go here including lorem ipsum will go here including lorem ipsum"
        

        return cell
    }
    
    
    var selectedCellIndexPath: NSIndexPath?
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if selectedCellIndexPath != nil && selectedCellIndexPath?.row == indexPath.row {
            selectedCellIndexPath = nil
        } else {
            selectedCellIndexPath = indexPath as NSIndexPath?
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
        if selectedCellIndexPath != nil {
            // This ensures, that the cell is fully visible once expanded
            tableView.scrollToRow(at: indexPath, at: .none, animated: true)
        }
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedCellIndexPath?.row == indexPath.row {
            return Utils.shared.screenSize().height * 0.4
        }
        return Utils.shared.screenSize().height * 0.2
    }
}

extension HomeTabMainView: CellTopDetailsContainerViewDelegate {
    func likeTapped() {
        print("tapped")
    }
}


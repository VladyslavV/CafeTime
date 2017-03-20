//
//  CafeDetailsSuperMainView.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 3/16/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SnapKit

class CafeDetailsMainView: UIView {
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviews([topImageView, tableView])
        self.setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Vars
    private let topImageView: UIImageView = {
        let myVar = UIImageView()
        myVar.image = UIImage(named: "superSandwich")
        myVar.contentMode = .scaleToFill
        return myVar
    }()

    fileprivate lazy var tableView: BaseTableView = {
        let myVar = BaseTableView()
        myVar.tableFooterView = UIView()
        myVar.backgroundColor = Colors.Clear
        return myVar
    }()
    
    lazy var headerView: CellDetailsHeaderView = {
        let myVar = CellDetailsHeaderView()
        // myVar.delegate = self
        return myVar
    }()
    
    
    // MARK: Set Up
    
    private func setUp() {
        
        topImageView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(self)
            make.height.equalTo(self.snp.height).multipliedBy(0.4)
        }
        
        topImageView.darken(percent: 0.5)
    }
    
    // MARK: Public
    
    func setDataSource(dataSource: UITableViewDataSource, withScroll scroll: Bool) {
        tableView.dataSource = dataSource
        self.reloadTableView(tableView, scrollToFirstItem: scroll)
    }
    
    func reloadTableView(_ tableView: UITableView, scrollToFirstItem scroll: Bool) {
        let contentOffset = tableView.contentOffset
        tableView.reloadData()
        tableView.layoutIfNeeded()
        tableView.setContentOffset(contentOffset, animated: false)
        if scroll {
            tableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .bottom, animated: true)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let vc = self.parentViewController!
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(vc.topLayoutGuide.snp.bottom)
            make.leading.trailing.bottom.equalTo(self)
        }
        
        if (tableView.tableHeaderView == nil) {
            tableView.tableHeaderView = self.headerView
            tableView.sizeHeaderToFit()
            tableView.reloadData()
        }
        
        headerView.updateGrayViewConstraints()
    }
        
}

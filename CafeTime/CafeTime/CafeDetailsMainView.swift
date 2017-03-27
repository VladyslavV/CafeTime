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
        let myVar = BaseTableView(withStyle: .grouped)
        myVar.tableFooterView = UIView()
        myVar.backgroundColor = Colors.clear
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
        tableView.delegate = self
        tableView.dataSource = dataSource
        self.reloadTableView(tableView, scrollToFirstItem: scroll)
    }
    
    func setDelegate(delegate: UITableViewDelegate) {
        tableView.delegate = delegate
        tableView.reloadData()
    }
    
    private func reloadTableView(_ tableView: UITableView, scrollToFirstItem scroll: Bool) {
        let contentOffset = tableView.contentOffset
        tableView.reloadData()
        tableView.layoutIfNeeded()
        tableView.setContentOffset(contentOffset, animated: false)
        if scroll {
            tableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .middle, animated: true)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, -20, 0);
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

extension CafeDetailsMainView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: CGRect.zero)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}


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
    
    let menuViewModel = MenuViewModel()
    let mapViewModel = MapViewModel()
    let bookViewModel = BookViewModel()
    
    var tableScrolledToTop: ((Bool) -> ())!

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
         myVar.menuBar.delegate = self
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
    
    func setDelegate(delegate: UITableViewDelegate?, dataSource: UITableViewDataSource, withScroll scroll: Bool) {
        tableView.delegate = delegate ?? self
        tableView.dataSource = dataSource
        self.reloadTableView(tableView, scrollToFirstItem: scroll)
    }

    private func reloadTableView(_ tableView: UITableView, scrollToFirstItem scroll: Bool) {
        let contentOffset = tableView.contentOffset
        tableView.reloadData()
        tableView.layoutIfNeeded()

       // self.setNeedsLayout()
        tableView.setContentOffset(contentOffset, animated: false)
        let indexPath = IndexPath.init(row: 0, section: 0)
        print(tableView.hasRowAtIndexPath(indexPath: indexPath as NSIndexPath))
        if scroll {
            tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
        }
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, -20, 0);
        //let vc = self.parentViewController!
        
        tableView.snp.makeConstraints { (make) in
        //make.top.equalTo(vc.topLayoutGuide.snp.bottom)
            make.leading.trailing.bottom.top.equalTo(self)
        }
        
        if (tableView.tableHeaderView == nil) {
            tableView.tableHeaderView = self.headerView
            tableView.sizeHeaderToFit()
            tableView.reloadData()
        }
        
        headerView.updateGrayViewConstraints()
        
        self.pageSelectedAtRow(row: 0)
    }
    
    func reload(section: Int?) {
        guard let sec = section else { self.tableView.reloadData(); return }
        tableView.reloadSections(IndexSet(integer: sec), with: .none)
    }
    
}

extension CafeDetailsMainView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: CGRect.zero)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.y > 40 ? tableScrolledToTop(false) : tableScrolledToTop(true)
    }
}

extension CafeDetailsMainView: ReusableMenuCollectionViewDelegate {
 
    internal func pageSelectedAtRow(row: Int) {
        
        switch row {
        case 0:
            self.setDelegate(delegate: nil, dataSource: menuViewModel, withScroll: false)
            break
        case 1:
            self.setDelegate(delegate: nil, dataSource: mapViewModel, withScroll: true)
            break
        case 2:
            self.setDelegate(delegate: bookViewModel, dataSource: bookViewModel, withScroll: true)
            break
        default: break
        }
    }
}

extension UITableView {
    func hasRowAtIndexPath(indexPath: NSIndexPath) -> Bool {
        return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
    }
}


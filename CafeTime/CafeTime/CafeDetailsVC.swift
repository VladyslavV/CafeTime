//
//  CafeDetailsVC.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/27/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SnapKit

class CafeDetailsVC: BaseVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = Colors.PrimaryGray
        self.view.addSubviews([mainView])
        self.setUp()
        
        self.pageSelectedAtRow(row: 0)
    }
    
    // MARK: Vars
    private var topImageView: UIImageView = {
        let myVar = UIImageView()
        myVar.image = UIImage(named: "superSandwich")
        myVar.contentMode = .scaleToFill
        return myVar
    }()
    
    fileprivate lazy var mainView: CafeDetailsMainView = {
        let myVar = CafeDetailsMainView()
        myVar.headerView.menuBar.delegate = self
        return myVar
    }()
    
    let menuDataSource = MenuViewModel()
    let mapDataSource = MapViewModel()
    
    
    // MARK: Set Up
    
    private func setUp() {

        self.navigationItem.title = "Restaurant"
        
        mainView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(self.view)
            make.bottom.equalTo(self.bottomLayoutGuide.snp.top)
        }
    }
        
    // MARK: Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navBar?.isHidden = false
        navBar?.transparentNavigationBar()
    }
    
}

extension CafeDetailsVC: ReusableMenuCollectionViewDelegate {
    
    internal func pageSelectedAtRow(row: Int) {
        
        switch row {
        case 0:
            mainView.setDataSource(dataSource: menuDataSource, withScroll: false)
            break
        case 1:
            mainView.setDataSource(dataSource: mapDataSource, withScroll: true)
            break
        case 2:
            break
        default: break
        }
    }
}


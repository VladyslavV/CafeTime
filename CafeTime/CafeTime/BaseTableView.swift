//
//  BasicTableView.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 3/18/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit

class BaseTableView: UITableView {

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(withStyle style: UITableViewStyle) {
        super.init(frame: .zero, style: style)
        self.setUp()
    }
    
    private func setUp() {
        
        self.register(UITableViewCell.self, forCellReuseIdentifier: Constants.TableViewCells.IDs.Default)

        self.register(PrimaryTableViewCell.self, forCellReuseIdentifier: Constants.TableViewCells.IDs.Primary)
        

        self.estimatedRowHeight = 10
        self.rowHeight = UITableViewAutomaticDimension
        self.tableFooterView = UIView()
        self.backgroundColor = Colors.clear
        self.separatorStyle = .none
        self.separatorInset = UIEdgeInsets.zero
    }

}

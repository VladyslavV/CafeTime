//
//  FavoritesPageMainView.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/22/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SnapKit

class FavoritesPageMainView: UIView {
    
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
    
    fileprivate var data = ["item 1", "item 2", "item 3", "item 4"]
    
    internal let cellID = "cell"
    fileprivate lazy var tableView: UITableView = {
        let myVar = UITableView()
        myVar.backgroundColor = UIColor.lightGray
        myVar.register(FavoritesPageCell.self, forCellReuseIdentifier: self.cellID)
        myVar.tableFooterView = UIView()
        myVar.separatorStyle = .none
        myVar.separatorInset = UIEdgeInsets.zero
        myVar.estimatedRowHeight = 2.0
        myVar.rowHeight = UITableViewAutomaticDimension
        myVar.delegate = self
        myVar.dataSource = self
        return myVar
    }()
    
    private lazy var tableViewTapGesture: UITapGestureRecognizer = {
        let myVar = UITapGestureRecognizer(target: self, action: #selector(tapEdit(_:)))
        self.tableView.addGestureRecognizer(myVar)
        return myVar
    }()
    
    // MARK: Set Up
    
    private func setUp() {
        self.tableViewTapGesture.isEnabled = true
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    //MARK: Actions
    
    private var previousCell: FavoritesPageCell?
    
    func tapEdit(_ recognizer: UITapGestureRecognizer)  {
        
        self.tableView.tapInCell(recognizer: recognizer) { (tapIndexPath, tapLocation) in
            
            let favPageCell = self.tableView.cellForRow(at: tapIndexPath) as! FavoritesPageCell
            
            let tapViewToDeleteCell = favPageCell.containerView.rightImageView
            
            let convertedPoint = self.tableView.convert(tapLocation, to: favPageCell.containerView)
            
            if tapViewToDeleteCell.frame.contains(convertedPoint) {
                self.handleDeletingState(tapIndexPath: tapIndexPath)
            }
            
        }
    }
    
    private func handleDeletingState(tapIndexPath: IndexPath) {
        
        let currentCell = self.tableView.cellForRow(at: tapIndexPath) as! FavoritesPageCell
        
        // handle previous cell
        if let prevCell = previousCell {
            if prevCell.isEqual(currentCell) {
                currentCell.editingState = (false, true)
                previousCell = nil
                return
            }
            else {
                prevCell.editingState = (false,true)
            }
        }
        
        if currentCell.editingState.0 {
            currentCell.editingState = (false, true)
            return
        }
        
        currentCell.editingState = (true,true)
        tableView.scrollToRow(at: tapIndexPath, at: .none, animated: true)
        previousCell = currentCell
    }
}


extension FavoritesPageMainView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! FavoritesPageCell
        
        cell.delegate = self
        cell.containerView.titleLabel.text = data[indexPath.row]
        cell.containerView.detailLabel.text = "Some description of Burger King. Some other text will go here for testing purposes!"
        
        return cell
    }
}

extension FavoritesPageMainView: FavoritesPageCellDelegate {
    
    func deleteCell(cell: FavoritesPageCell) {
        print("delete")
        let cellIndexPath = self.tableView.indexPath(for: cell)
        if let indexPath = cellIndexPath {
            data.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        
    }
    
}

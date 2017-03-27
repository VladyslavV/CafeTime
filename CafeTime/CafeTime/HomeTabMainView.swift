//
//  HomeTabMainView.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/15/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit

protocol HomeTabMainViewDelegate: class {
    func cellTapped(inRow row: Int)
}

class HomeTabMainView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(tableView)
        self.backgroundColor = Colors.primaryGray
        self.setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Vars
    
    weak var delegate: HomeTabMainViewDelegate?
    
    fileprivate lazy var tableView: BaseTableView = {
        let myVar = BaseTableView(withStyle: .plain)
        myVar.delegate = self
        myVar.dataSource = self
        return myVar
    }()
    
    private var previousCell: PrimaryTableViewCell?
    
    private lazy var tableViewTapGesture: UITapGestureRecognizer = {
        let myVar = UITapGestureRecognizer(target: self, action: #selector(tapEdit(_:)))
        self.tableView.addGestureRecognizer(myVar)
        return myVar
    }()
    
    private func setUp() {
        tableViewTapGesture.isEnabled = true
        tableView.snp.remakeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    // MARK: Actions
    
    func tapEdit(_ recognizer: UITapGestureRecognizer)  {
        
        self.tableView.tapInCell(recognizer: recognizer) { (tapIndexPath, tapLocation) in
            
            let homeTabCell = self.tableView.cellForRow(at: tapIndexPath) as! PrimaryTableViewCell
            
            let detailTextLabel = homeTabCell.mainContainerView.topContainerView.detailLabel
            let likeImageView = homeTabCell.mainContainerView.topContainerView.likeImageView
            
            let convertedPoint = self.tableView.convert(tapLocation, to: homeTabCell.mainContainerView.topContainerView)
            
            if likeImageView.frame.contains(convertedPoint) {
                self.handleLikeTapped(tapIndexPath: tapIndexPath)
            }
            else if homeTabCell.showingDetails {
                self.delegate?.cellTapped(inRow: tapIndexPath.row)
            }
            else if detailTextLabel.frame.contains(convertedPoint) {
                self.handleDetailsLabelTap(tapIndexPath: tapIndexPath)
            }
            else {
                homeTabCell.showingDetails = false
                self.delegate?.cellTapped(inRow: tapIndexPath.row)
            }
        }
    }
    
    private func handleLikeTapped(tapIndexPath: IndexPath) {
        print("like tapped")
    }
    
    private func handleDetailsLabelTap(tapIndexPath: IndexPath) {
        
        let currentCell = self.tableView.cellForRow(at: tapIndexPath) as! PrimaryTableViewCell
        
        if let prevCell = previousCell {
            if prevCell.isEqual(currentCell)  {
                previousCell = nil
                return
            }
            else {
                prevCell.showingDetails = false
            }
        }
        
        currentCell.showingDetails = true
        previousCell = currentCell
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
        tableView.scrollToRow(at: tapIndexPath, at: .none, animated: true)
    }
    
}


// MARK: TableView Delegate

extension HomeTabMainView: UITableViewDelegate, UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      
        let cell = self.tableView.dequeueReusableCell(withIdentifier: Constants.TableViewCells.IDs.Primary, for: indexPath) as! PrimaryTableViewCell    
        
        cell.mainContainerView.topContainerView.titleLabel.text = "Title"
        cell.mainContainerView.topContainerView.detailLabel.text = "Many details will go here including lorem ipsum!!! details will go here including lorem ipsum details will go here including lorem ipsum will go here including lorem ipsum will go here including lorem ipsum will go here including lorem ipsum"
        
        
        return cell
    }
}


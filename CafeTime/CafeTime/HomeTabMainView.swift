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
        self.setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Vars
    
    weak var delegate: HomeTabMainViewDelegate?
    
    internal lazy var tableView: UITableView = {
        let myVar = UITableView()
        myVar.register(HomeTabCell.self, forCellReuseIdentifier: "homeTabCell")
        myVar.tableFooterView = UIView()
        myVar.separatorStyle = .none
        myVar.separatorInset = UIEdgeInsets.zero
        myVar.estimatedRowHeight = 200
        myVar.rowHeight = UITableViewAutomaticDimension
        myVar.delegate = self
        myVar.dataSource = self
        return myVar
    }()
    
    internal var selectedCellIndexPath: IndexPath?
    
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
    
    func disableTableViewTapRecognizer() {
        tableViewTapGesture.isEnabled = false
    }
    
    func enableTableViewTapRecognizer() {
        tableViewTapGesture.isEnabled = true
    }
    
    func tapEdit(_ recognizer: UITapGestureRecognizer)  {
        if recognizer.state == UIGestureRecognizerState.ended {
            let tapLocation = recognizer.location(in: self.tableView)
            if let tapIndexPath = self.tableView.indexPathForRow(at: tapLocation) {
                if let tappedCell = self.tableView.cellForRow(at: tapIndexPath) as? HomeTabCell {
                    let detailTextLabel = tappedCell.mainContainerView.topContainerView.detailLabel
                    let likeImageView = tappedCell.mainContainerView.topContainerView.likeImageView

                    let convertedPoint = self.tableView.convert(tapLocation, to: tappedCell.mainContainerView.topContainerView)
                    
                    if likeImageView.frame.contains(convertedPoint) {
                        self.handleLikeTapped(tappedCell: tappedCell, tapIndexPath: tapIndexPath)
                    }
                    else if tappedCell.showingDetails {
                        self.delegate?.cellTapped(inRow: tapIndexPath.row)
                    }
                    else if detailTextLabel.frame.contains(convertedPoint) {
                        self.handleDetailsLabelTap(tappedCell: tappedCell, tapIndexPath: tapIndexPath)
                    }
                    else {
                        tappedCell.showingDetails = false
                        self.delegate?.cellTapped(inRow: tapIndexPath.row)
                    }
                }
            }
        }
    }
    
    private func handleLikeTapped(tappedCell: HomeTabCell, tapIndexPath: IndexPath) {
        print("like tapped")
    }
    
    private func handleDetailsLabelTap(tappedCell: HomeTabCell, tapIndexPath: IndexPath) {
        // hide details for previous cell
        if let indexPath = selectedCellIndexPath {
            let previousCell = self.tableView.cellForRow(at: indexPath) as? HomeTabCell
            previousCell?.showingDetails = false
        }
        // show current cell details
        tappedCell.showingDetails = true
        
        if selectedCellIndexPath != nil && selectedCellIndexPath?.row == tapIndexPath.row {
            selectedCellIndexPath = nil
        } else {
            selectedCellIndexPath = tapIndexPath as IndexPath?
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
        if selectedCellIndexPath != nil {
            // This ensures, that the cell is fully visible once expanded
            tableView.scrollToRow(at: tapIndexPath, at: .none, animated: true)
        }
    }
    
}


// MARK: TableView Delegate

extension HomeTabMainView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "homeTabCell", for: indexPath) as! HomeTabCell
        
        cell.mainContainerView.topContainerView.titleLabel.text = "Title"
        cell.mainContainerView.topContainerView.detailLabel.text = "Many details will go here including lorem ipsum!!! details will go here including lorem ipsum details will go here including lorem ipsum will go here including lorem ipsum will go here including lorem ipsum will go here including lorem ipsum"
        
        
        return cell
    }
}


//
//  Book.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 3/17/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit

class BookViewModel: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    override init() {
        super.init()

        calendarView.reloadTableViewHandler = { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.reloadTableViewHandler!(Sections.date)
        }
    }
    
    enum Sections: Int{
        
        case date = 0
        case time = 1
        case numberOfGuests = 2
        case comments = 3
        
        static var allValues:[Sections] {
            return [ .time, .date, .numberOfGuests, .comments]
        }
    }
    
    //MARK: Vars
    var reloadTableViewHandler: ((Sections) -> ())?
    
    //private let calendarView = FSCalendarView()
    private let calendarView = CVCCalendarControl()

    //MARK: number of rows and section
    func numberOfSections(in tableView: UITableView) -> Int {
        return Sections.allValues.count

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var numberOfRows = 0
        
        switch(section){
            case Sections.date.rawValue: numberOfRows = 1; break
            case Sections.time.rawValue: numberOfRows = 1; break
            case Sections.numberOfGuests.rawValue: numberOfRows = 1; break
            case Sections.comments.rawValue: numberOfRows = 1; break
            default: break
        }
        
        return numberOfRows
    }
    
    //MARK: cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "")
        
        if indexPath.section == Sections.date.rawValue {
            
            cell.contentView.addSubview(calendarView)
            calendarView.snp.makeConstraints({ (make) in
                make.edges.equalTo(cell.contentView)
            })
        }
        
        if indexPath.section == Sections.time.rawValue {

        }
        
        if indexPath.section == Sections.numberOfGuests.rawValue {

        }
        
        if indexPath.section == Sections.comments.rawValue {

        }

        
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.orange
        
//        cell.contentView.snp.remakeConstraints { (make) in
////            make.leading.trailing.top.equalTo(cell)
////            make.height.equalTo(300)
//            
//            make.edges.equalTo(cell)
//        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
                
        let header = BookSectionHeaderView()
        
        if section == Sections.date.rawValue {
            header.titleLabel.text = "Date"
        }
        
        if section == Sections.time.rawValue {
            header.titleLabel.text = "Time"
        }
        
        if section == Sections.numberOfGuests.rawValue {
            header.titleLabel.text = "Number of guests"
        }
        
        if section == Sections.comments.rawValue {
            header.titleLabel.text = "Comments"
        }
        
        return header
    }

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: CGRect.zero)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }

}

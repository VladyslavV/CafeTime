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
    var tableScrolledToTop: ((Bool) -> ())!

    private let calendarView = FSCalendarView()
    private let circleTimer = CircleTimeSlider()
    
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
        cell.contentView.backgroundColor = Colors.primaryGray
        
        if indexPath.section == Sections.date.rawValue {
            
            cell.contentView.addSubview(calendarView)
            calendarView.snp.makeConstraints({ (make) in
                make.edges.equalTo(cell.contentView)
            })
        }
        
        if indexPath.section == Sections.time.rawValue {
            
            cell.contentView.addSubview(circleTimer)
            circleTimer.snp.makeConstraints({ (make) in
                make.edges.equalTo(cell.contentView)
                make.height.equalTo(300)
            })
        }
        
        if indexPath.section == Sections.numberOfGuests.rawValue {

        }
        
        if indexPath.section == Sections.comments.rawValue {

        }

        
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.orange

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
                
        let header = BookSectionHeaderView()
        
        if section == Sections.date.rawValue {
            header.titleLabel.text = NSLocalizedString("cafedetails.book.date.section.title", comment: "Set the date")
        }
        
        if section == Sections.time.rawValue {
            header.titleLabel.text = NSLocalizedString("cafedetails.book.time.section.title", comment: "Set the time")
        }
        
        if section == Sections.numberOfGuests.rawValue {
            header.titleLabel.text = NSLocalizedString("cafedetails.book.number.of.guests.section.title", comment: "Number of guests")
        }
        
        if section == Sections.comments.rawValue {
            header.titleLabel.text = NSLocalizedString("cafedetails.book.comments.section.title", comment: "Comments")
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.y > 40 ? tableScrolledToTop(false) : tableScrolledToTop(true)
    }

}

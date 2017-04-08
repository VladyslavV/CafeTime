//
//  FSCalendarView.swift
//  CafeTime
//
//  Created by Vladyslav Vyshnevksyy on 3/27/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import FSCalendar
import SnapKit

class FSCalendarView: UIView {
    
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(calendarView)
        calendarView.addSubviews([leftHeaderButton, rightHeaderButton])

        self.backgroundColor = Colors.primaryGray
        
        calendarView.appearance.calendar.bottomBorder.backgroundColor = Colors.clear
        calendarView.calendarHeaderView.backgroundColor = Colors.clear

        calendarView.delegate = self
        calendarView.dataSource = self
        
        calendarView.firstWeekday = 2
        calendarView.pagingEnabled = true
        
        //header
                
        calendarView.appearance.headerMinimumDissolvedAlpha = 0.0;
        calendarView.appearance.headerTitleColor = UIColor.black
        calendarView.appearance.weekdayTextColor = UIColor.black

        //main
    //  calendarView.appearance.titleDefaultColor = UIColor.red
        calendarView.appearance.selectionColor = UIColor.green
        calendarView.appearance.eventDefaultColor = UIColor.green
        
        calendarView.placeholderType = .fillHeadTail
        
        // today
       // calendarView.appearance.todaySelectionColor = UIColor.green
        calendarView.appearance.todayColor = Colors.primaryGray
        calendarView.appearance.titleTodayColor = UIColor.black
        
        self.setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Vars
    
    let calendarView = FSCalendar(frame: CGRect.zero)
    
    lazy var leftHeaderButton: UIButton = {
        let myVar = UIButton(type: .system)
        myVar.backgroundColor = UIColor.green
        myVar.addTarget(self, action: #selector(left), for: .touchUpInside)
        return myVar
    }()
    
    lazy var rightHeaderButton: UIButton = {
        let myVar = UIButton(type: .system)
        myVar.backgroundColor = UIColor.green
        myVar.addTarget(self, action: #selector(right), for: .touchUpInside)
        return myVar
    }()
    
    
    //MARK: Funcs
    
    @objc private func left() {
        if let previousMonth = NSCalendar.current.date(byAdding: .month, value: -1, to: calendarView.currentPage) {
            calendarView.setCurrentPage(previousMonth, animated: true)
        }
    }
    
    @objc private func right() {
        if let nextMonth = NSCalendar.current.date(byAdding: .month, value: 1, to: calendarView.currentPage) {
            calendarView.setCurrentPage(nextMonth, animated: true)
        }
    }
    
    // MARK: Set Up
    private func setUp() {
        
        leftHeaderButton.snp.makeConstraints { (make) in
            make.leading.top.bottom.equalTo(calendarView.calendarHeaderView)
            make.width.equalTo(calendarView.calendarHeaderView.snp.width).multipliedBy(0.1)
        }
        
        rightHeaderButton.snp.makeConstraints { (make) in
            make.trailing.top.bottom.equalTo(calendarView.calendarHeaderView)
            make.width.equalTo(calendarView.calendarHeaderView.snp.width).multipliedBy(0.1)
        }
        
        calendarView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
            make.height.equalTo(300)
        }
    }
}

extension FSCalendarView: FSCalendarDelegate, FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {

        let yesterday = NSCalendar.current.date(byAdding: .day, value: -1, to: Date())!
        
        if  date < yesterday {
            cell.isUserInteractionEnabled = false
            cell.preferredTitleDefaultColor = UIColor.lightGray
            cell.appearance.titleDefaultColor = UIColor.lightGray
        }
        else {
            cell.isUserInteractionEnabled = true
            cell.appearance.titleDefaultColor = UIColor.black
        }
    
    }
  
    
    public func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(date.currentTimeZoneDate())
//        let calendar = Calendar.current
//        let month = calendar.component(.month, from: date)
//        let day = calendar.component(.day, from: date)

    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
    }
    
//    public func calendar(_ calendar: FSCalendar, hasEventFor date: Date) -> Bool {
//        if self.today == date {
//            return true
//        }
//        return false
//    }
}



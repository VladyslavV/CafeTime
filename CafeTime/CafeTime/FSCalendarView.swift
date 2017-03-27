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

class FSCalendarView: FSCalendar {
    
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.delegate = self
        self.dataSource = self
        
        self.firstWeekday = 2
        
        self.calendarHeaderView.backgroundColor = Colors.clear
        self.appearance.headerMinimumDissolvedAlpha = 0.0;
        
        self.appearance.headerTitleColor = UIColor.black
        self.appearance.weekdayTextColor = UIColor.black
        self.appearance.todayColor = UIColor.green
        self.appearance.selectionColor = UIColor.darkGray
        self.placeholderType = .fillHeadTail
        
        self.addSubviews([leftHeaderButton, rightHeaderButton])
        
        self.backgroundColor = Colors.primaryGray
        
        self.setUp()
        
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Vars
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
        if let previousMonth = NSCalendar.current.date(byAdding: .month, value: -1, to: self.currentPage) {
            self.setCurrentPage(previousMonth, animated: true)
        }
    }
    
    @objc private func right() {
        if let nextMonth = NSCalendar.current.date(byAdding: .month, value: 1, to: self.currentPage) {
            self.setCurrentPage(nextMonth, animated: true)
        }
    }
    
    // MARK: Set Up
    private func setUp() {
        
        leftHeaderButton.snp.makeConstraints { (make) in
            make.leading.top.bottom.equalTo(self.calendarHeaderView)
            make.width.equalTo(self.calendarHeaderView.snp.width).multipliedBy(0.1)
        }
        
        rightHeaderButton.snp.makeConstraints { (make) in
            make.trailing.top.bottom.equalTo(self.calendarHeaderView)
            make.width.equalTo(self.calendarHeaderView.snp.width).multipliedBy(0.1)
        }
    }
}

extension FSCalendar: FSCalendarDelegate, FSCalendarDataSource {
    
    public func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(date)
    }
}

//
//  CVCCalendarControl.swift
//  CafeTime
//
//  Created by Vladyslav Vyshnevksyy on 4/3/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import CVCalendar
import SnapKit

class CVCCalendarControl: UIView, CVCalendarViewDelegate, CVCalendarMenuViewDelegate {

    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviews([menuView, calendarView])
        
        // Appearance delegate [Unnecessary]
        self.calendarView.calendarAppearanceDelegate = self
        
        // Animator delegate [Unnecessary]
        self.calendarView.animatorDelegate = self
        
        // Menu delegate [Required]
        self.menuView.menuViewDelegate = self
        
        // Calendar delegate [Required]
        self.calendarView.calendarDelegate = self
        
        self.setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.menuView.commitMenuViewUpdate()
        self.calendarView.commitCalendarViewUpdate()
    }
    
    // MARK: Vars
    let menuView = CVCalendarMenuView()
    let calendarView = CVCalendarView()
    
    var reloadTableViewHandler: (() ->())?
    
    // MARK: Set Up
    
    private func setUp() {
        
        menuView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(self)
            make.height.equalTo(60)
        }

        calendarView.snp.makeConstraints { (make) in
            make.top.equalTo(menuView.snp.bottom)
            make.leading.trailing.bottom.equalTo(self)
            make.height.equalTo(200)
        }
    }
    
    //MARK: Delegate
    
    func presentationMode() -> CalendarMode {
        return .monthView
    }
    
    func firstWeekday() -> Weekday {
        return .monday
    }
    
    func shouldAnimateResizing() -> Bool {
        self.reloadTableViewHandler!()
        return true
    }
}

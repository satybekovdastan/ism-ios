//
//  CalendarPopupViewController.swift
//  ism
//
//  Created by Atay Sultangaziev on 12/22/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit
import Koyomi

class CalendarPopupViewController: UIViewController {

    @IBOutlet weak var titleYearLabel: UILabel!
    @IBOutlet weak var titleAbbreviatedLabel: UILabel!
    @IBOutlet weak var titleFullLabel: UILabel!
    @IBOutlet weak var calendarView: UIView!
    
    @IBOutlet weak var backArrowButton: UIButton!
    @IBOutlet weak var forwardArrowButton: UIButton!
    var selectedDate: Date!
    
    var koyomiCalendar: Koyomi! {
        didSet {
            koyomiCalendar.calendarDelegate = self
            
            koyomiCalendar.display(in: .current)
            
            titleYearLabel.text = koyomiCalendar.currentDateString(withFormat: "yyyy")
            
            let today = Date()
            
            let fullLabelFormatter = DateFormatter()
            fullLabelFormatter.dateStyle = .medium
            fullLabelFormatter.timeStyle = .none
            fullLabelFormatter.locale = Locale(identifier: "ru_MD")
            titleFullLabel.sizeToFit()
            titleFullLabel.text = fullLabelFormatter.string(from: today)
            
            let abbreviatedLabelFormatter = DateFormatter()
            abbreviatedLabelFormatter.dateStyle = .short
            abbreviatedLabelFormatter.timeStyle = .none
            abbreviatedLabelFormatter.locale = Locale(identifier: "ru_MD")
            titleAbbreviatedLabel.text = abbreviatedLabelFormatter.string(from: today)
            
            koyomiCalendar.select(date: today)
            koyomiCalendar.setDayFont(size: 15).setWeekFont(size: 12)
        }
    }
    
    @IBAction func backArrowTapped(_ sender: UIButton) {
        koyomiCalendar?.display(in: .previous)
    }
    
    @IBAction func forwardArrowTapped(_ sender: UIButton) {
        koyomiCalendar?.display(in: .next)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCalendarView()
        
    }
    
    
    
    func setupCalendarView() {
        print("hello")
        
        backArrowButton.setImage(#imageLiteral(resourceName: "calendarBackButton"), for: .normal)
        forwardArrowButton.setImage(#imageLiteral(resourceName: "calendarForwardButton"), for: .normal)
        
        
        let frame = CGRect(x: 0, y : 0, width: 300, height: 230)
        koyomiCalendar = Koyomi(frame: frame, sectionSpace: 1.5, cellSpace: 0.5, inset: .zero, weekCellHeight: 25)
        calendarView.addSubview(koyomiCalendar)
        
    }
    
    @IBAction func cancelTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func okTapped(_ sender: Any) {
        NotificationCenter.default.post(name: .saveDate, object: self)
        dismiss(animated: true)
    }
    
}

extension CalendarPopupViewController: KoyomiDelegate {
    func koyomi(_ koyomi: Koyomi, didSelect date: Date?, forItemAt indexPath: IndexPath) {
        selectedDate = date
    }
    
    func koyomi(_ koyomi: Koyomi, currentDateString dateString: String) {
        
    }
    
    @objc(koyomi:shouldSelectDates:to:withPeriodLength:)
    func koyomi(_ koyomi: Koyomi, shouldSelectDates date: Date?, to toDate: Date?, withPeriodLength length: Int) -> Bool {
        return true
    }
    
}

extension Notification.Name {
    static let saveDate = Notification.Name("saveDate")
}

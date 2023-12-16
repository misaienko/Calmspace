//
//  TrackViewController.swift
//  Calmspace
//
//  Created by Admin on 29/11/2023.
//

import UIKit
import FSCalendar

struct CalendarData {
    var day: Int
    var month: Int
    var year: Int
}

class TrackViewController: UIViewController,  FSCalendarDelegate, FSCalendarDataSource {
    
    @IBOutlet weak var calendarView: FSCalendar!
    
    @IBOutlet weak var monthSwitch: UISwitch!
    
    @IBOutlet weak var monthLabel: UILabel!
    
    @IBOutlet weak var trackStatement: UITextField!
    
    var calendarData: [CalendarData] = []
    
    var selectedMonth: Int = 1
    let selectedYear: Int = 2024
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
            calendarView.delegate = self
            calendarView.dataSource = self
        
            reloadCalendar()
        
            monthSwitch.addTarget(self, action: #selector(switchToggled), for: .valueChanged)
        }
        
      @objc func switchToggled() {
            selectedMonth = monthSwitch.isOn ? 2 : 1
            reloadCalendar()
        }

        func reloadCalendar() {
 
            calendarData.removeAll()
         
            for day in 1...31 {
                if day <= daysInMonth(month: selectedMonth, year: selectedYear) {
                    calendarData.append(CalendarData(day: day, month: selectedMonth, year: selectedYear))
                }
            }
            
            calendarView.reloadData()

            updateMonthLabel()
        }
        
        func updateMonthLabel() {
            let dateFormatter = DateFormatter()
            let monthName = dateFormatter.monthSymbols[selectedMonth - 1] // Adjust index
            monthLabel.text = "\(monthName) \(selectedYear)"
        }
        
    func daysInMonth(month: Int, year: Int) -> Int {
            let calendar = Calendar.current
            let dateComponents = DateComponents(year: year, month: month)
            let date = calendar.date(from: dateComponents)!
            let range = calendar.range(of: .day, in: .month, for: date)!
            return range.count
        }
    }
    
       

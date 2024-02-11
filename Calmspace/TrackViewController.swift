//
//  TrackViewController.swift
//  Calmspace
//
//  Created by Admin on 29/11/2023.
//

import UIKit
import FSCalendar

extension UIColor {
    static let forestGreen = UIColor(red: 45/255.0, green: 67/255.0, blue: 34/255.0, alpha: 1.0)
}

class TrackViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var trackStatement: UITextField!
    
    var selectedMonth: Int = 1
    let selectedYear: Int = 2024
    var selectedDates: [Date] = []
    var selectedOptions: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarView.delegate = self
        calendarView.dataSource = self
        calendarView.appearance.headerMinimumDissolvedAlpha = 0.0
        calendarView.appearance.titleFont = UIFont(name: "AvenirNext-DemiBold", size: 16)
        calendarView.appearance.headerTitleFont = UIFont(name: "AvenirNext-DemiBold", size: 15)
        calendarView.layer.cornerRadius = 15
        calendarView.layer.masksToBounds = true
        calendarView.appearance.headerTitleOffset = CGPoint(x: 3, y: 15)
        
        setupNavigationButtons()
        
        scheduleDailyReminder()
        
        reloadCalendar()
    }
    
    func setupNavigationButtons() {
        let prevMonthButton = UIButton(type: .system)
        prevMonthButton.setTitle("Previous Month", for: .normal)
        prevMonthButton.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
        prevMonthButton.addTarget(self, action: #selector(prevMonthTapped), for: .touchUpInside)
        self.view.addSubview(prevMonthButton)
        
        let nextMonthButton = UIButton(type: .system)
        nextMonthButton.setTitle("Next Month", for: .normal)
        nextMonthButton.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
        nextMonthButton.addTarget(self, action: #selector(nextMonthTapped), for: .touchUpInside)
        self.view.addSubview(nextMonthButton)
        
        prevMonthButton.translatesAutoresizingMaskIntoConstraints = false
        nextMonthButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            prevMonthButton.topAnchor.constraint(equalTo: calendarView.topAnchor, constant: 10),
            prevMonthButton.leadingAnchor.constraint(equalTo: calendarView.leadingAnchor, constant: 20),
            
            nextMonthButton.topAnchor.constraint(equalTo: calendarView.topAnchor, constant: 10),
            nextMonthButton.trailingAnchor.constraint(equalTo: calendarView.trailingAnchor, constant: -20),
        ])
    }
    
    @objc func prevMonthTapped() {
        let prevMonth = Calendar.current.date(byAdding: .month, value: -1, to: calendarView.currentPage)
        calendarView.setCurrentPage(prevMonth!, animated: true)
        reloadCalendar()
    }
    
    @objc func nextMonthTapped() {
        let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: calendarView.currentPage)
        calendarView.setCurrentPage(nextMonth!, animated: true)
        reloadCalendar()
    }
    
    func scheduleDailyReminder() {
        scheduleReminder(hour: 8, minute: 0, identifier: "morningReminder")
        scheduleReminder(hour: 19, minute: 0, identifier: "eveningReminder")
    }
    
    func scheduleReminder(hour: Int, minute: Int, identifier: String) {
        let content = UNMutableNotificationContent()
        content.title = "Meditation and Yoga Reminder"
        content.body = "Don't forget about your Meditation and Yoga Routine"
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error scheduling \(identifier): \(error.localizedDescription)")
            } else {
                print("\(identifier) scheduled successfully")
            }
        }
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        if selectedDates.contains(where: { Calendar.current.isDate($0, inSameDayAs: date) }) {
            if let index = selectedDates.firstIndex(where: { Calendar.current.isDate($0, inSameDayAs: date) }) {
                let selectedOption = selectedOptions[index]
                switch selectedOption {
                case 1, 2:
                    return .yellow
                case 3:
                    return UIColor.forestGreen
                default:
                    break
                }
            }
        }
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if selectedDates.contains(where: { Calendar.current.isDate($0, inSameDayAs: date) }) {
            if let index = selectedDates.firstIndex(where: { Calendar.current.isDate($0, inSameDayAs: date) }) {
                let selectedOption = selectedOptions[index]
                updateTrackStatement(option: selectedOption)
            }
        } else {
            let alertController = UIAlertController(title: "Select an option", message: nil, preferredStyle: .actionSheet)
            
            let option1Action = UIAlertAction(title: "Completed Yoga", style: .default) { _ in
                self.handleOptionSelection(option: 1, date: date)
            }
            
            let option2Action = UIAlertAction(title: "Completed Meditation", style: .default) { _ in
                self.handleOptionSelection(option: 2, date: date)
            }
            
            let option3Action = UIAlertAction(title: "Completed Meditation & Yoga", style: .default) { _ in
                self.handleOptionSelection(option: 3, date: date)
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alertController.addAction(option1Action)
            alertController.addAction(option2Action)
            alertController.addAction(option3Action)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
        }
    }
    
    func handleOptionSelection(option: Int, date: Date) {
        if !selectedDates.contains(where: { Calendar.current.isDate($0, inSameDayAs: date) }) {
            selectedDates.append(date)
            selectedOptions.append(option)
        } else {
            if let index = selectedDates.firstIndex(where: { Calendar.current.isDate($0, inSameDayAs: date) }) {
                selectedOptions[index] = option
            }
        }
        updateTrackStatement(option: option)
        calendarView.reloadData()
    }
    
    func updateTrackStatement(option: Int) {
        switch option {
        case 1:
            trackStatement.text = "Your Body in Balance"
        case 2:
            trackStatement.text = "Your Mind in Balance"
        case 3:
            trackStatement.text = "Body & Mind in Balance"
        default:
            break
        }
    }
    
    func reloadCalendar() {
        print("Reload calendar data")
    }
}


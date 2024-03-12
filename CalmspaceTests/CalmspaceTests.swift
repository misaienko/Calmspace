//
//  CalmspaceTests.swift
//  CalmspaceTests
//
//  Created by Admin on 16/07/2023.

import XCTest
@testable import Calmspace

final class CalmspaceTests: XCTestCase {
    
    var adviceViewController: AdviceViewController!
    var trackViewController: TrackViewController!
    var sut: MainChoiceViewController!
    
    override func setUp() {
        super.setUp()
        
        let adviceStoryboard = UIStoryboard(name: "Main", bundle: nil)
        adviceViewController = adviceStoryboard.instantiateViewController(withIdentifier: "AdviceViewController") as? AdviceViewController
        _ = adviceViewController.view
        
        let trackStoryboard = UIStoryboard(name: "Main", bundle: nil)
        trackViewController = trackStoryboard.instantiateViewController(withIdentifier: "TrackViewController") as? TrackViewController
        _ = trackViewController.view
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        sut = mainStoryboard.instantiateViewController(withIdentifier: "MainChoiceViewController") as? MainChoiceViewController
    }
    
    override func tearDown() {
        adviceViewController = nil
        trackViewController = nil
        super.tearDown()
    }
    
    func testCorrectAdvice() {
        
        let testCases: [(SelectedOption?, String)] = [
            (SelectedOption(feelingTodayLevel: .bad, botheringReason: .physically, hasExercised: false, hasSpentTimeOutside: true), "Let's have a Yoga Practice!"),
            (SelectedOption(feelingTodayLevel: .okay, botheringReason: .mentally, hasExercised: true, hasSpentTimeOutside: true), "Let's have a Meditation outside!"),
            (SelectedOption(feelingTodayLevel: .bad, botheringReason: .physically, hasExercised: false, hasSpentTimeOutside: false), "Let's have a quick Yoga outside!"),
            (SelectedOption(feelingTodayLevel: .good, botheringReason: .mentally, hasExercised: false, hasSpentTimeOutside: false), "Let's have a Meditation & Yoga outside!"),
            (SelectedOption(feelingTodayLevel: .good, botheringReason: nil, hasExercised: false, hasSpentTimeOutside: true), "Let's have a quick Yoga Practice!"),
            (SelectedOption(feelingTodayLevel: .okay, botheringReason: .mentally, hasExercised: false, hasSpentTimeOutside: true), "Let's have a quick Yoga & Meditation!"),
            (SelectedOption(feelingTodayLevel: .bad, botheringReason: .mentally, hasExercised: true, hasSpentTimeOutside: true), "Let's have a Meditation!"),
            (SelectedOption(feelingTodayLevel: .good, botheringReason: .mentally, hasExercised: true, hasSpentTimeOutside: true),"Let's have a short Meditation!"),
            (nil, "No advice available for the selected option")
        ]
        
        for (selectedOption, expectedAdvice) in testCases {
            
            guard let selectedOption = selectedOption else {
                print("Error: Selected option is nil")
                continue
            }
            print("Selected Option:", selectedOption)
            adviceViewController.selectedOption = selectedOption
            adviceViewController.displayAdvice()
            guard let actualAdvice = adviceViewController.adviceText.text else {
                print("Error: Actual advice is nil")
                continue
            }
            print("Expected Advice:", expectedAdvice)
            print("Actual Advice:", actualAdvice)
            XCTAssertEqual(actualAdvice, expectedAdvice)
        }
    }
    
    func testDailyReminder() {
        
        trackViewController.scheduleDailyReminder()
        
        let center = UNUserNotificationCenter.current()
        center.getPendingNotificationRequests { requests in
            
            XCTAssertEqual(requests.count, 2)
            
            for request in requests {
                XCTAssertEqual(request.content.title, "Meditation and Yoga Reminder")
                XCTAssertEqual(request.content.body, "Don't forget about your Meditation and Yoga Routine")
                XCTAssertTrue(request.trigger is UNCalendarNotificationTrigger)
            }
        }
    }
    
    func testCorrect_data() {
        
        DispatchQueue.main.async {
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let sut = mainStoryboard.instantiateViewController(withIdentifier: "MainChoiceViewController") as! MainChoiceViewController
            let meditationVC = MeditationViewController()
            let yogaVC = YogaViewController()
            
            _ = sut.view
            
            sut.performSegue(withIdentifier: "MeditationSegue", sender: nil)
            
            XCTAssertNotNil(meditationVC.meditationSections)
            XCTAssertEqual(meditationVC.meditationSections, sut.meditationSections)
            
            sut.performSegue(withIdentifier: "YogaSegue", sender: nil)
            
            XCTAssertNotNil(yogaVC.yogaSections)
            XCTAssertEqual(yogaVC.yogaSections, sut.yogaSections)
        }
    }
}



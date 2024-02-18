//
//  CalmspaceTests.swift
//  CalmspaceTests
//
//  Created by Admin on 16/07/2023.

import XCTest
@testable import Calmspace

final class CalmspaceTests: XCTestCase {
    
    var viewController: AdviceViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "AdviceViewController") as? AdviceViewController
        _ = viewController.view
    }
    
    override func tearDown() {
        viewController = nil
        super.tearDown()
    }
    
    func testAdviceSelection() {
        
        viewController.selectedOption = nil
        
        viewController.displayAdvice()
        
        XCTAssertEqual(viewController.adviceText.text, "Invalid selection")
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
            viewController.selectedOption = selectedOption
            viewController.displayAdvice()
            guard let actualAdvice = viewController.adviceText.text else {
                print("Error: Actual advice is nil")
                continue
            }
            print("Expected Advice:", expectedAdvice)
            print("Actual Advice:", actualAdvice)
            XCTAssertEqual(actualAdvice, expectedAdvice)
        }
    }
}

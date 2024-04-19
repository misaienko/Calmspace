//
//  CalmspaceTests.swift
//  CalmspaceTests
//
//  Created by Admin on 16/07/2023.

import XCTest

@testable import Calmspace

final class CalmspaceTests: XCTestCase {
    
   var adviceViewController: AdviceViewController!
   var sut: MainChoiceViewController!
   var detailsVC: DetailsTableViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        adviceViewController = storyboard.instantiateViewController(withIdentifier: "AdviceViewController") as? AdviceViewController
        sut = storyboard.instantiateViewController(withIdentifier: "MainChoiceViewController") as? MainChoiceViewController
        detailsVC = storyboard.instantiateViewController(withIdentifier: "DetailsTableViewController") as? DetailsTableViewController
        
        _ = adviceViewController.view
        _ = sut.view
        _ = detailsVC.view
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
    
    func testPracticeDataPopulation() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let detailsVC = storyboard.instantiateViewController(withIdentifier: "DetailsTableViewController") as? DetailsTableViewController else {
                XCTFail("Expected DetailsTableViewController instance")
                return
            }
            _ = detailsVC.view
        
            let practiceLinks = [
                PracticeLinks(title: "Meditate: Be Present", youtubeLink: URL(string: "https://youtu.be/ZToicYcHIOU?si=K4XlfymPvdSVhGqo")!),
                PracticeLinks(title: "Morning Meditation: Inner Peace", youtubeLink: URL(string: "https://youtu.be/UAEqdo0Dn-k?si=wte3qJK5yvcK6aUw")!),
                PracticeLinks(title: "Morning Meditation: Inner Strength", youtubeLink: URL(string: "https://youtu.be/p5Num5Pg8yo?si=Cof5lwuCcnh10ixk")!)
            ]

            detailsVC.activitiesArray = practiceLinks
            detailsVC.tableView.reloadData()

            for (index, link) in practiceLinks.enumerated() {
                let indexPath = IndexPath(row: index, section: 0)
                let cell = detailsVC.tableView(detailsVC.detailsTable, cellForRowAt: indexPath)

                guard let configuration = cell.contentConfiguration as? UIListContentConfiguration else {
                    XCTFail("Failed to retrieve content configuration from cell")
                    continue
                }

                XCTAssertEqual(configuration.text, link.title, "Cell at row \(index) should display the title: \(link.title)")
  
            }
     }
}



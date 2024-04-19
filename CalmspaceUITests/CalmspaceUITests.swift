//
//  CalmspaceUITests.swift
//  CalmspaceUITests
//
//  Created by Admin on 16/07/2023.
//

import XCTest

final class CalmspaceUITests: XCTestCase {
    
    var app: XCUIApplication!
    var webView: XCUIElement!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testFullNavigationFlow() throws {
        navigateToQuestionsView()
        selectAnswers()
        navigateToAdviceView()
        navigateToMainChoice()
        selectActivityOption()
        navigateToDetailsView()
        openWebView()
    }
    
    func testButtonTitleUpdates() {
        navigateToQuestionsView()
        
        let expectedButtonTitles = [
            ["Physically", "Mentally", "No"],
            ["Yes", "No", ""],
            ["Yes", "No", ""]
        ]
        
        for i in 0..<3 {
            
            XCTAssertTrue(app.buttons["answerButton1"].waitForExistence(timeout: 10))
            app.buttons["answerButton1"].tap()
            
            let currentButton1Title = app.buttons["answerButton1"].label
            let currentButton2Title = app.buttons["answerButton2"].label
            
            var currentButton3Title = ""
            if app.buttons["answerButton3"].exists {
                currentButton3Title = app.buttons["answerButton3"].label
            }
            print("Interaction \(i + 1):")
            print("Current Button 1 Title: \(currentButton1Title)")
            print("Current Button 2 Title: \(currentButton2Title)")
            print("Current Button 3 Title: \(currentButton3Title)")
            
            XCTAssertEqual(currentButton1Title, expectedButtonTitles[i][0], "Button 1 title did not update correctly")
            XCTAssertEqual(currentButton2Title, expectedButtonTitles[i][1], "Button 2 title did not update correctly")
            XCTAssertEqual(currentButton3Title, expectedButtonTitles[i][2], "Button 3 title did not update correctly")
        }
    }
    
    func testQuestionTextUpdates() {
        navigateToQuestionsView()
        
        let expectedQuestionTexts = [
            "What is bothering you?",
            "Did you exercise today?",
            "Did you spend time outside today?"
        ]
        
        for i in 0..<3 {
            
            XCTAssertTrue(app.buttons["answerButton1"].waitForExistence(timeout: 10))
            app.buttons["answerButton1"].tap()
            
            let currentQuestionText = app.textFields["questionText"].value as! String
            print("Interaction \(i + 1):")
            print("Current Question Text: \(currentQuestionText)")
            
            XCTAssertEqual(currentQuestionText, expectedQuestionTexts[i], "Question text did not update correctly")
        }
    }
    
    private func navigateToQuestionsView() {
        XCTAssertTrue(app.buttons["suggestActivity"].waitForExistence(timeout: 10))
        app.buttons["suggestActivity"].tap()
    }
    
    private func selectAnswers() {
        for _ in 0..<4 {
            XCTAssertTrue(app.buttons["answerButton1"].waitForExistence(timeout: 10))
            app.buttons["answerButton1"].tap()
        }
    }
    
    private func navigateToAdviceView() {
        XCTAssertTrue(app.buttons["commandButton"].waitForExistence(timeout: 10))
        app.buttons["commandButton"].tap()
    }
    
    private func navigateToMainChoice() {
        
        var selectedChoice: String?
        
        if app.buttons["meditationButton"].exists {
            app.buttons["meditationButton"].tap()
            selectedChoice = "Meditation"
        } else if app.buttons["yogaButton"].exists {
            app.buttons["yogaButton"].tap()
            selectedChoice = "Yoga"
        }
        XCTAssertNotNil(selectedChoice, "No main choice was selected")
        XCTAssertEqual(selectedChoice, "Meditation", "Selected choice should be Meditation")
    }
    
    private func selectActivityOption() {
        
        var selectedActivity: String?
        
        if app.cells["meditation_0"].waitForExistence(timeout: 10) {
            app.cells["meditation_0"].tap()
            selectedActivity = "Meditation"
        } else if app.cells["yoga_0"].waitForExistence(timeout: 10) {
            app.cells["yoga_0"].tap()
            selectedActivity = "Yoga"
        }
        XCTAssertNotNil(selectedActivity, "No activity was selected")
        XCTAssertEqual(selectedActivity, "Meditation", "Selected activity should be Meditation")
    }
    
    private func navigateToDetailsView() {
        XCTAssertTrue(app.cells["details_0"].waitForExistence(timeout: 10))
        app.cells["details_0"].tap()
    }
    
    private func openWebView() {
        webView = app.webViews["webViewIdentifier"].firstMatch
        if webView.waitForExistence(timeout: 10) {
            webView.swipeDown()
            sleep(2)
        } else {
            XCTFail("Web view not found")
        }
    }
    
}

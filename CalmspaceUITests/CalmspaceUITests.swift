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
        XCTAssertTrue(app.buttons["suggestActivity"].waitForExistence(timeout: 10))
        app.buttons["suggestActivity"].tap()
        
        var tapCount = 0
        
        while tapCount < 4 {
            XCTAssertTrue(app.buttons["answerButton1"].waitForExistence(timeout: 10))
            app.buttons["answerButton1"].tap()
            tapCount += 1
        }
        
        XCTAssertTrue(app.buttons["commandButton"].waitForExistence(timeout: 10))
        app.buttons["commandButton"].tap()
        
        XCTAssertTrue(app.buttons["meditationButton"].waitForExistence(timeout: 10) || app.buttons["yogaButton"].waitForExistence(timeout: 10))
        
        if app.buttons["meditationButton"].exists {
            app.buttons["meditationButton"].tap()
        } else if app.buttons["yogaButton"].exists {
            app.buttons["yogaButton"].tap()
        }
        
        if app.cells["meditation_0"].waitForExistence(timeout: 10) {
            app.cells["meditation_0"].tap()
        } else if app.cells["yoga_0"].waitForExistence(timeout: 10) {
            app.cells["yoga_0"].tap()
        }
        
        XCTAssertTrue(app.cells["details_0"].waitForExistence(timeout: 10))
        app.cells["details_0"].tap()
        
        webView = app.webViews["webViewIdentifier"].firstMatch
        if webView.waitForExistence(timeout: 10) {
            webView.swipeDown()
            sleep(2)
        } else {
            XCTFail("Web view not found")
        }
    }
}



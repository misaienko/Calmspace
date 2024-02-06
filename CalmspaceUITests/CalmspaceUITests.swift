//
//  CalmspaceUITests.swift
//  CalmspaceUITests
//
//  Created by Admin on 16/07/2023.
//

import XCTest

final class CalmspaceUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testSelectCellInDetailsView() {
            let detailsTableView = app.tables["detailsTable"]
            let cellToSelect = detailsTableView.cells.element(matching: .cell, identifier: "optionCell_0")
            XCTAssertTrue(cellToSelect.waitForExistence(timeout: 10), "Cell not found")
            cellToSelect.tap()
            XCTAssertTrue(app.navigationBars["DisplayViewController"].waitForExistence(timeout: 10), "Navigation to DisplayViewController failed")
        }
    
    func testLoadURL() {
        app.launchArguments.append("--uitesting")
        app.launch()
        let webView = app.webViews.element
        XCTAssertTrue(webView.waitForExistence(timeout: 10), "Web view not found")
        if webView.exists {
            print("Web view found")
        } else {
            print("Web view not found")
        }
    }

    func testRefreshButton() {
        app.launchArguments.append("--uitesting")
        app.launch()
        let refreshButton = app.buttons["refreshButton"]
        XCTAssertTrue(refreshButton.waitForExistence(timeout: 10), "Refresh button not found")
        if refreshButton.exists {
            print("Refresh button found")
        } else {
            print("Refresh button not found")
        }
    }

    func testStopButton() {
        app.launchArguments.append("--uitesting")
        app.launch()
        let stopButton = app.buttons["stopButton"]
        XCTAssertTrue(stopButton.waitForExistence(timeout: 10), "Stop button not found")
        if stopButton.exists {
            print("Stop button found")
        } else {
            print("Stop button not found")
        }
    }
}

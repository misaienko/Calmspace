//
//  CalmspaceTests.swift
//  CalmspaceTests
//
//  Created by Admin on 16/07/2023.
//

import XCTest
@testable import Calmspace

final class CalmspaceTests: XCTestCase {
    var viewController: FirstAskViewController!

    override func setUpWithError() throws {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "FirstAskViewController") as? FirstAskViewController
        viewController.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        viewController = nil
        super.tearDown()
    }

    func testUIElementsExist() {
        XCTAssertNotNil(viewController.questionText)
        XCTAssertNotNil(viewController.answerButton1)
        XCTAssertNotNil(viewController.answerButton2)
        XCTAssertNotNil(viewController.answerButton3)
        XCTAssertNotNil(viewController.backgroundImageView)
    }

    func testButtonFontIsSet() {
        let button = UIButton()
        viewController.setButtonFont(for: button)
        XCTAssertEqual(button.titleLabel?.font, UIFont(name: "AvenirNext-DemiBold", size: 19))
    }

    func testButtonShadowIsSet() {
        let button = UIButton()
        viewController.setButtonShadow(for: button)
        XCTAssertEqual(button.layer.shadowColor, UIColor.black.cgColor)
    }
}

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
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "FirstAskViewController") as? FirstAskViewController else {
            XCTFail("Failed to instantiate FirstAskViewController from storyboard")
            return
        }
        self.viewController = viewController
        
        print("FirstAskViewController instantiated successfully")
        viewController.loadViewIfNeeded()
        print("View loaded successfully")
    }
    
    override func tearDownWithError() throws {
        viewController = nil
        super.tearDown()
    }
    
    func testUIElementsExist() {
        XCTAssertNotNil(viewController.questionText, "questionText outlet is not set")
        XCTAssertNotNil(viewController.answerButton1, "answerButton1 outlet is not set")
        XCTAssertNotNil(viewController.answerButton2, "answerButton2 outlet is not set")
        XCTAssertNotNil(viewController.answerButton3, "answerButton3 outlet is not set")
        XCTAssertNotNil(viewController.backgroundImageView, "backgroundImageView outlet is not set")
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

//
//  YassirMoviesUITests.swift
//  YassirMoviesUITests
//
//  Created by Pietro Messineo on 05/03/24.
//

import XCTest

final class YassirMoviesUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    func testHeaderView() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Open menu and select Upcoming filter
        tapButton(withAccessibilityIdentifier: "menuFilter", inApp: app)
        tapButton(withAccessibilityIdentifier: "upcomingFilterButton", inApp: app)
        
        // Verify Upcoming content
        verifyElementExists(withAccessibilityIdentifier: "popularContentLabel", expectedLabel: "Coming soon", inApp: app)
        
        // Open menu and select Popular filter
        tapButton(withAccessibilityIdentifier: "menuFilter", inApp: app)
        tapButton(withAccessibilityIdentifier: "popularFilterButton", inApp: app)
        
        // Verify Popular content
        verifyElementExists(withAccessibilityIdentifier: "popularContentLabel", expectedLabel: "Popular", inApp: app)
    }

    private func tapButton(withAccessibilityIdentifier identifier: String, inApp app: XCUIApplication) {
        let button = app.buttons[identifier]
        XCTAssertTrue(button.exists, "Button with identifier '\(identifier)' does not exist.")
        button.tap()
    }

    private func verifyElementExists(withAccessibilityIdentifier identifier: String, expectedLabel: String, inApp app: XCUIApplication) {
        let element = app.staticTexts[identifier]
        let existsPredicate = NSPredicate(format: "exists == true")
        expectation(for: existsPredicate, evaluatedWith: element, handler: nil)
        waitForExpectations(timeout: 2, handler: nil)
        XCTAssertEqual(element.label, expectedLabel, "The element's label is not '\(expectedLabel)'")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

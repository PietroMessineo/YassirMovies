//
//  DateExtensionsTest.swift
//  YassirMoviesTests
//
//  Created by Pietro Messineo on 06/03/24.
//

import XCTest
@testable import YassirMovies

final class DateExtensionsTest: XCTestCase {
    
    let dateFormatter = DateFormatter()
    
    override func setUpWithError() throws {
        super.setUp()
        dateFormatter.dateFormat = "yyyy-MM-dd"
    }
    
    // Tests for getReleaseStatus()
    func testGetReleaseStatusForToday() throws {
        let today = Date()
        XCTAssertEqual(today.getReleaseStatus(), "Released", "Today's date should return Released")
    }
    
    func testGetReleaseStatusForPastDate() throws {
        let pastDate = dateFormatter.date(from: "1995-11-22")!
        XCTAssertEqual(pastDate.getReleaseStatus(), "Released", "Past date should return Released")
    }
    
    // Tests for todaysFormattedDate()
    func testTodaysFormattedDate() {
        let today = Date()
        let formattedDate = today.todaysFormattedDate()
        let expectedDate = dateFormatter.string(from: today)
        
        XCTAssertEqual(formattedDate, expectedDate, "Formatted date should match today's date in yyyy-MM-dd format.")
    }
}

//
//  TmdbManagerTests.swift
//  YassirMoviesTests
//
//  Created by Pietro Messineo on 06/03/24.
//

import XCTest
@testable import YassirMovies

@MainActor
class TmdbManagerTests: XCTestCase {
    func testGetMoviesEditorsChoice() async {
        let mockService = MockTmdbService()
        let manager = TmdbManager(service: mockService)

        // Setup the mock response
        let fakeItems = [Items(backdrop_path: "backdrop_path", id: 12, original_title: "Movie Title", release_date: Date(), poster_path: "poster_path")]
        mockService.editorsChoiceResponseToReturn = EditorsChoiceResponse(id: 123, items: fakeItems)

        do {
            try await manager.getMoviesEditorsChoice()
            XCTAssertNotNil(manager.movieEditorsChoice)
            XCTAssertEqual(manager.movieEditorsChoice?.first?.original_title, "Movie Title")
        } catch {
            XCTFail("Test failed due to an unexpected error: \(error).")
        }
    }
}

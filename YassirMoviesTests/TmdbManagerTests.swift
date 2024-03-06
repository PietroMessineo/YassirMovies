//
//  TmdbManagerTests.swift
//  YassirMoviesTests
//
//  Created by Pietro Messineo on 06/03/24.
//

import XCTest
import ModelPackage

@testable import YassirMovies

@MainActor
class TmdbManagerTests: XCTestCase {
    func testGetMoviesEditorsChoice() async {
        let mockService = MockTmdbService()
        let manager = TmdbManager(service: mockService)

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
    
    func testGetMovieDetails() async {
        let mockService = MockTmdbService()
        let manager = TmdbManager(service: mockService)
        
        let fakeMovieDetails = MovieDetailsResponse(success: true, id: 1, original_title: "Fake Movie", release_date: Date(), overview: "A fake movie used for testing.", credits: nil, videos: nil, poster_path: "poster_path", runtime: 120)
        mockService.movieDetailsToReturn = fakeMovieDetails
        
        do {
            try await manager.getMovieDetails(id: "1")
            XCTAssertNotNil(manager.movieDetails)
            XCTAssertEqual(manager.movieDetails?.original_title, "Fake Movie")
            XCTAssertEqual(manager.movieDetails?.runtime, 120)
        } catch {
            XCTFail("Test failed due to an unexpected error: \(error).")
        }
    }
}


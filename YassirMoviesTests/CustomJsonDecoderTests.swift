//
//  CustomJsonDecoderTests.swift
//  YassirMoviesTests
//
//  Created by Pietro Messineo on 06/03/24.
//

import XCTest
@testable import YassirMovies

final class JSONDecoderExtensionsTests: XCTestCase {
    
    func testCustomDateDecoder() {
        let decoder = JSONDecoder.customDateDecoder
        let jsonString = """
                         {"date":"2024-03-05"}
                         """
        struct TestModel: Codable {
            let date: Date
        }
        
        do {
            let data = jsonString.data(using: .utf8)!
            let result = try decoder.decode(TestModel.self, from: data)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let expectedDate = dateFormatter.date(from: "2024-03-05")!
            
            XCTAssertEqual(result.date, expectedDate, "The decoded date does not match the expected date.")
        } catch {
            XCTFail("Decoding failed with error: \(error)")
        }
    }
    
    func testCustomDateDecoderWithCustomStrategy_ValidDate() {
        let decoder = JSONDecoder.customDateDecoderWithCustomStrategy
        let jsonString = "{\"date\":\"2024-03-05\"}" // A valid date string in the expected format.
        struct TestModel: Codable {
            let date: Date
        }

        do {
            let data = jsonString.data(using: .utf8)!
            let result = try decoder.decode(TestModel.self, from: data)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let expectedDate = dateFormatter.date(from: "2024-03-05")!
            
            XCTAssertEqual(result.date, expectedDate, "The decoded date should match the expected valid date.")
        } catch {
            XCTFail("Decoding failed for a valid date string with error: \(error)")
        }
    }
    
    func testCustomDateDecoderWithCustomStrategy_InvalidDate() {
        let decoder = JSONDecoder.customDateDecoderWithCustomStrategy
        let jsonString = "{\"date\":\"Invalid-Date-String\"}" // A wrong date format.
        struct TestModel: Codable {
            let date: Date
        }

        let data = jsonString.data(using: .utf8)!
        XCTAssertThrowsError(try decoder.decode(TestModel.self, from: data)) { error in
            if case .dataCorrupted = error as? DecodingError {
                // Success: decoding expectedly failed with a data corrupted error.
            } else {
                XCTFail("Expected DecodingError.dataCorrupted, but received \(error)")
            }
        }
    }
    
    func testCustomDateDecoderWithCustomStrategy_EmptyDate() {
        let decoder = JSONDecoder.customDateDecoderWithCustomStrategy
        let jsonString = "{\"date\":\"\"}" // Empty date string.
        struct TestModel: Codable {
            let date: Date
        }
        
        do {
            let data = jsonString.data(using: .utf8)!
            let result = try decoder.decode(TestModel.self, from: data)
                    
            let expectedDate = Date()
            
            XCTAssertEqual(result.date.timeIntervalSince1970, expectedDate.timeIntervalSince1970, accuracy: 1.0, "The decoded date should default to the current date for an empty string.")
        } catch {
            XCTFail("Decoding failed for an empty date string with error: \(error)")
        }
    }
}

//
//  JSONDecoder+Extension.swift
//  YassirMovies
//
//  Created by Pietro Messineo on 05/03/24.
//

import Foundation

extension JSONDecoder {
    // Custom date decoder that returns a JSONDecoder with a predefined date format (yyyy-MM-dd).
    static var customDateDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        // Configures the decoder to use a specific format for date strings.
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }
    
    // Custom date decoder with a strategy to handle date strings manually. Needed because sometimes the search for movies was broken due to wrong format of date (ex. Timestamp instead of date) returned by the search API 
    static var customDateDecoderWithCustomStrategy: JSONDecoder {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        // Uses a custom strategy for decoding dates, allowing manual handling of possible date formats and errors.
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            // Attempts to decode the date string; nil if it cannot find a value or if the value is an empty string.
            let dateString = try? container.decode(String.self)
            if let dateString = dateString, !dateString.isEmpty {
                // Try to convert the string to a Date object using the predefined formatter.
                if let date = dateFormatter.date(from: dateString) {
                    return date
                } else {
                    // If the date string does not match the expected format, throw a decoding error.
                    throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date format")
                }
            } else {
                // If no date string is found or if it is empty, return the current date as a default value.
                return Date()
            }
        }
        return decoder
    }
}

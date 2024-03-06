//
//  MovieDetailsResponse.swift
//  YassirMovies
//
//  Created by Pietro Messineo on 05/03/24.
//

import Foundation

struct MovieDetailsResponse: Codable {
    let success: Bool?
    let id: Int?
    let original_title: String?
    let release_date: Date?
    let overview: String?
    let credits: Credits?
    let videos: Videos?
    let poster_path: String?
    let runtime: Int?
}

struct Credits: Codable {
    let cast: [Person]?
    let crew: [Person]?
}

struct Person: Codable {
    let name: String?
    let character: String?
    let id: Int
    let profile_path: String?
    let known_for_department: String?
    let poster_path: String?
}

struct Videos: Codable {
    let results: [Results]?
}

struct Results: Codable {
    let name: String?
    let type: String?
    let published_at: String?
    let key: String?
    let id: String?
}

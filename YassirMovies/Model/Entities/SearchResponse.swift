//
//  SearchResponse.swift
//  YassirMovies
//
//  Created by Pietro Messineo on 05/03/24.
//

import Foundation

struct SearchResponse: Codable {
    let results: [SearchResult]?
}

struct SearchResult: Codable, Identifiable, Hashable {
    let backdrop_path: String?
    let id: Int
    let name: String?
    let title: String?
    let original_language: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let media_type: String?
    let first_air_date: Date?
    let release_date: Date?
    let known_for_department: String?
    let profile_path: String?
}

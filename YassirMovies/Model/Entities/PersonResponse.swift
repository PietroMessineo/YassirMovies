//
//  PersonResponse.swift
//  YassirMovies
//
//  Created by Pietro Messineo on 05/03/24.
//

import Foundation

struct PersonResponse: Codable {
    let id: Int?
    let name: String?
    let biography: String?
    let birthday: Date?
    let deathday: Date?
    let movie_credits: Credits?
    let known_for_department: String?
    let profile_path: String?
}

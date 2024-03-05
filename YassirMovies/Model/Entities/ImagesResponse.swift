//
//  ImagesResponse.swift
//  YassirMovies
//
//  Created by Pietro Messineo on 05/03/24.
//

import Foundation

struct ImagesResponse: Codable {
    let backdrops: [Backdrops]?
}

struct Backdrops: Codable, Identifiable {
    let id = UUID().uuidString
    let file_path: String?
}

//
//  WatchProvidersResponse.swift
//  YassirMovies
//
//  Created by Pietro Messineo on 05/03/24.
//

import Foundation

struct WatchProvidersResponse: Codable, Identifiable {
    let id: Int
    let results: [String: CountryResult]
}

struct CountryResult: Codable {
    let link: String
    let buy, rent, flatrate: [Provider]?

    enum CodingKeys: String, CodingKey {
        case link, buy, rent
        case flatrate = "flatrate"
    }
}

struct Provider: Codable, Identifiable {
    let id = UUID().uuidString
    let logoPath: String
    let providerID: Int
    let providerName: String
    let displayPriority: Int
    var subtitle: String?

    enum CodingKeys: String, CodingKey {
        case logoPath = "logo_path"
        case providerID = "provider_id"
        case providerName = "provider_name"
        case displayPriority = "display_priority"
    }
}

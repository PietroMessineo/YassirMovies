//
//  TmdbService.swift
//  YassirMovies
//
//  Created by Pietro Messineo on 05/03/24.
//

import Foundation

struct TmdbService: HTTPClient {
    func getEditorsChoice() async throws -> EditorsChoiceResponse {
        return try await request(
            endpoint: TmdbEndpoint.editorsChoice, responseModel: EditorsChoiceResponse.self, decoder: .customDateDecoder
        )
    }
    
    func getDiscover(page: Int, movieList: DiscoverMovieList) async throws -> DiscoverResponse {
        return try await request(
            endpoint: TmdbEndpoint.getMovieDiscover(page: page, movieList: movieList), responseModel: DiscoverResponse.self, decoder: .customDateDecoder
        )
    }
}

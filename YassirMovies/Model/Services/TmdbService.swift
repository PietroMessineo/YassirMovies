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
    
    func getImages(movieId: String) async throws -> ImagesResponse {
        return try await request(endpoint: TmdbEndpoint.getImages(movieId: movieId), responseModel: ImagesResponse.self)
    }
    
    func getMovieDetails(id: String) async throws -> MovieDetailsResponse {
        return try await request(
            endpoint: TmdbEndpoint.getMovieDetails(id: id), responseModel: MovieDetailsResponse.self, decoder: .customDateDecoderWithCustomStrategy
        )
    }
    
    func getPerson(id: String) async throws -> PersonResponse {
        return try await request(endpoint: TmdbEndpoint.getPerson(id: id), responseModel: PersonResponse.self, decoder: .customDateDecoder)
    }
    
    func searchFor(query: String) async throws -> SearchResponse {
        return try await request(
            endpoint: TmdbEndpoint.searchFor(query: query), responseModel: SearchResponse.self, decoder: .customDateDecoderWithCustomStrategy)
    }
    
    func getMovieWatchProviders(movieId: String) async throws -> WatchProvidersResponse {
        return try await request(
            endpoint: TmdbEndpoint.getWatchProviders(movieId: movieId), responseModel: WatchProvidersResponse.self, decoder: .customDateDecoder)
    }
}

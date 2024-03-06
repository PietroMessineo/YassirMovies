//
//  TmdbManager.swift
//  YassirMovies
//
//  Created by Pietro Messineo on 05/03/24.
//

import Foundation

@MainActor
final class TmdbManager: ObservableObject {
    let service: TmdbService = TmdbService()
    
    @Published var isLoading = false
    @Published var movieEditorsChoice: [Items]?
    @Published var movieDetails: MovieDetailsResponse?
    @Published var movieDiscoverList: [Items] = []
    @Published var searchResults: [SearchResult] = []
    @Published var movieWatchProviders: [String: CountryResult] = [:]
    
    func getMoviesEditorsChoice() async throws {
        isLoading = true
        let editorsChoiceResponse = try await service.getEditorsChoice()
        if let items = editorsChoiceResponse.items {
            movieEditorsChoice = items
        }
        isLoading = false
    }
    
    func getMovieDetails(id: String) async throws {
        isLoading = true
        let movieDetail = try await service.getMovieDetails(id: id)
        movieDetails = movieDetail
        isLoading = false
    }
    
    func getMovieDiscover(page: Int, movieList: DiscoverMovieList) async throws {
        isLoading = true
        let discover = try await service.getDiscover(page: page, movieList: movieList)
        if let items = discover.results {
            movieDiscoverList.append(contentsOf: items)
        }
        isLoading = false
    }
    
    func searchFor(query: String) async throws {
        isLoading = true
        let searchResponse = try await service.searchFor(query: query)
        if let results = searchResponse.results {
            self.searchResults = results.filter({ $0.poster_path != nil || $0.profile_path != nil })
        }
        isLoading = false
    }
    
    func getMovieWatchProviders(movieId: String) async throws {
        isLoading = true
        let movieWatchProviders = try await service.getMovieWatchProviders(movieId: movieId)
        self.movieWatchProviders = movieWatchProviders.results
        isLoading = false
    }
}

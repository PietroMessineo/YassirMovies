//
//  TmdbManager.swift
//  YassirMovies
//
//  Created by Pietro Messineo on 05/03/24.
//

import Foundation

@MainActor
final class TmdbManager: ObservableObject {
    
    // Service protocol to abstract TMDB service details
    let service: TmdbServiceProtocol
    
    // Properties to track and update UI states and data
    @Published var isLoading = false // Indicates network activity
    @Published var movieEditorsChoice: [Items]? // Stores editor's choice movie list
    @Published var movieDetails: MovieDetailsResponse? // Stores details for a specific movie
    @Published var movieDiscoverList: [Items] = [] // Stores list of movies fetched from "Discover" API
    @Published var searchResults: [SearchResult] = [] // Stores results from a search query
    @Published var movieWatchProviders: [String: CountryResult] = [:] // Key-Value pairs of movie IDs and their available watch providers by country
    
    init(service: TmdbServiceProtocol = TmdbService()) {
        self.service = service
    }
    
    // Fetches and updates the editor's choice movies
    func getMoviesEditorsChoice() async throws {
        isLoading = true
        let editorsChoiceResponse = try await service.getEditorsChoice()
        if let items = editorsChoiceResponse.items {
            movieEditorsChoice = items
        }
        isLoading = false
    }
    
    // Fetches and updates the details for a single movie based on its ID
    func getMovieDetails(id: String) async throws {
        isLoading = true
        let movieDetail = try await service.getMovieDetails(id: id)
        movieDetails = movieDetail
        isLoading = false
    }
    
    // Fetches and appends movies from the Discover API to the existing discover list, supporting pagination
    func getMovieDiscover(page: Int, movieList: DiscoverMovieList) async throws {
        isLoading = true
        let discover = try await service.getDiscover(page: page, movieList: movieList)
        if let items = discover.results {
            movieDiscoverList.append(contentsOf: items) // Append new discoveries for infinite scrolling
        }
        isLoading = false
    }
    
    // Executes a search query and filters out results without images, updates searchResults
    func searchFor(query: String) async throws {
        isLoading = true
        let searchResponse = try await service.searchFor(query: query)
        if let results = searchResponse.results {
            // Store only results with images to ensure better UI
            self.searchResults = results.filter({ $0.poster_path != nil || $0.profile_path != nil })
        }
        isLoading = false
    }
    
    // Fetches available watch providers for a specific movie by its ID, useful for region-specific viewing options
    func getMovieWatchProviders(movieId: String) async throws {
        isLoading = true
        let movieWatchProviders = try await service.getMovieWatchProviders(movieId: movieId)
        self.movieWatchProviders = movieWatchProviders.results // Maps movie ID to available watch providers
        isLoading = false
    }
}

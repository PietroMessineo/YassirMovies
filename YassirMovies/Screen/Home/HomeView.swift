//
//  HomeView.swift
//  YassirMovies
//
//  Created by Pietro Messineo on 05/03/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var tmdbManager: TmdbManager
    
    @State var currentMovieList: DiscoverMovieList = .popular
    @State var currentPage: Int = 1
    
    var body: some View {
        ZStack {
            GeometryReader(content: { geometry in
                ScrollView {
                    if let movieEditorsChoice = tmdbManager.movieEditorsChoice {
                        CarouselView(spacing: 20, items: movieEditorsChoice.compactMap({ movieItem in
                            return CoverFlowItem(item: movieItem)
                        })) { movie in
                            NavigationLink(destination: MovieDetailView(movieId: movie.item.id, posterImage: nil) ) {
                                CarouselItemView(item: movie)
                            }
                        }
                        .frame(height: 200)
                    }
                    
                    PopularHeaderView(currentMovieList: $currentMovieList)
                    
                    MovieListView(currentPage: $currentPage, currentMovieList: $currentMovieList, screenWidth: geometry.size.width)
                }
            })
            
            if tmdbManager.isLoading {
                ProgressView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(edges: .bottom)
        .task {
            do {
                try await tmdbManager.getMoviesEditorsChoice()
                try await tmdbManager.getMovieDiscover(page: currentPage, movieList: currentMovieList)
            } catch {
                print("Error fetching editors choice \(error.localizedDescription)")
            }
        }
        .navigationTitle("Discover")
    }
}

#Preview {
    HomeView()
        .environmentObject(TmdbManager())
}

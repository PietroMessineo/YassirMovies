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
            ScrollView {
                if let movieEditorsChoice = tmdbManager.movieEditorsChoice {
                    CarouselView(spacing: 20, items: movieEditorsChoice.compactMap({ movieItem in
                        return CoverFlowItem(item: movieItem)
                    })) { item in
                        CarouselItemView(item: item)
                    }
                    .frame(height: 200)
                }
                
                MovieListView(currentPage: $currentPage, currentMovieList: $currentMovieList)
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

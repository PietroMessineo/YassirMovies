//
//  MovieDetailView.swift
//  YassirMovies
//
//  Created by Pietro Messineo on 05/03/24.
//

import SwiftUI
import Kingfisher

struct MovieDetailView: View {
    @EnvironmentObject var tmdbManager: TmdbManager
    
    let movieId: Int
    let posterImage: KFImage?
    
    @State var shouldCollapse: Bool = false
    @State var selectedTab: MovieDetailTab = .none
    @State var error: String?
    
    var body: some View {
        ZStack {
            DetailBackgroundView(posterImage: posterImage)
            if tmdbManager.movieDetails?.success == false {
                VStack {
                    Image(systemName: "popcorn")
                        .font(.system(size: 80))
                    Text("Oh oh... This movie couldn't be found")
                        .font(.system(size: 20, weight: .semibold))
                }
            } else {
                VStack {
                    GeometryReader(content: { geometry in
                        ScrollView {
                            // Poster + Title and Release Status
                            DetailHeaderView(shouldCollapse: $shouldCollapse, screenWidth: geometry.size.width, posterImage: posterImage)
                            if selectedTab == .none {
                                // Info related to release status and movie's duration
                                MovieDetailInfoView()
                            } else if selectedTab == .cast {
                                CastView()
                            } else if selectedTab == .watch {
                                WatchProviderView()
                            }
                        }
                    })
                    
                    Spacer()
                    
                    HStack {
                        HStack {
                            Spacer()
                            ButtonDetailTabView(selectedTab: $selectedTab, shouldCollapse: $shouldCollapse, currentTab: .cast)
                            Spacer()
                            ButtonDetailTabView(selectedTab: $selectedTab, shouldCollapse: $shouldCollapse, currentTab: .watch)
                            Spacer()
                        }
                    }
                }
            }
        }
        .task {
            do {
                try await tmdbManager.getMovieDetails(id: String(movieId))
                try await tmdbManager.getMovieWatchProviders(movieId: String(movieId))
            } catch {
                print("Error getting data \(error.localizedDescription)")
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onDisappear {
            // Get rid of movie details on dismissal
            tmdbManager.movieDetails = nil
            tmdbManager.movieWatchProviders = [:]
        }
    }
}

#Preview {
    MovieDetailView(movieId: 1028703, posterImage: nil)
        .environmentObject(TmdbManager())
}

enum MovieDetailTab: String {
    case cast = "Cast"
    case watch = "Watch"
    case none
}

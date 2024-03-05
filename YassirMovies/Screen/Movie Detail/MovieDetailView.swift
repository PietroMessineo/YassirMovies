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
    
    var body: some View {
        ZStack {
            DetailBackgroundView(posterImage: posterImage)
            
            GeometryReader(content: { geometry in
                ScrollView {
                    // Poster + Title and Release Status
                    DetailHeaderView(shouldCollapse: $shouldCollapse, screenWidth: geometry.size.width, posterImage: posterImage)
                }
            })
        }
        .task {
            do {
                try await tmdbManager.getMovieDetails(id: String(movieId))
                try await tmdbManager.getMovieImages(movieId: String(movieId))
                try await tmdbManager.getMovieWatchProviders(movieId: String(movieId))
            } catch {
                print("Error \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    MovieDetailView(movieId: 1028703, posterImage: nil)
        .environmentObject(TmdbManager())
}

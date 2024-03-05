//
//  MovieListView.swift
//  YassirMovies
//
//  Created by Pietro Messineo on 05/03/24.
//

import SwiftUI
import Kingfisher

struct MovieListView: View {
    @EnvironmentObject var tmdbManager: TmdbManager
    @Binding var currentPage: Int
    @Binding var currentMovieList: DiscoverMovieList
    
    let itemsPerRow = 3
    let gridSpacing: CGFloat = 10
    
    var body: some View {
        // LazyVGrid instead of a List for easy pagination
        LazyVGrid(columns: createGridColumns(itemsPerRow, gridSpacing), spacing: gridSpacing) {
            ForEach(0..<tmdbManager.movieDiscoverList.count, id: \.self) { index in
                if index == tmdbManager.movieDiscoverList.count - 1 {
                    // Load more items when the last item is visible
                    MovieThumbnailView(item: tmdbManager.movieDiscoverList[index])
                        .onAppear {
                            loadMoreItems()
                        }
                } else {
                    MovieThumbnailView(item: tmdbManager.movieDiscoverList[index])
                }
            }
        }
        .id("Grid")
        .padding(.horizontal, gridSpacing)
        .onAppear {
            // Load initial items
            loadMoreItems()
        }
    }
    
    private func createGridColumns(_ itemsPerRow: Int, _ gridSpacing: CGFloat) -> [GridItem] {
        var columns: [GridItem] = []
        for _ in 0..<itemsPerRow {
            columns.append(GridItem(.flexible(), spacing: gridSpacing))
        }
        return columns
    }
    
    func loadMoreItems() {
        currentPage += 1
        Task {
            do {
                try await tmdbManager.getMovieDiscover(page: currentPage, movieList: currentMovieList)
            } catch {
                print("Error getting movie discover \(error.localizedDescription)")
            }
        }
    }
}

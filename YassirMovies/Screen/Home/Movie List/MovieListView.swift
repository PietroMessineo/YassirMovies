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
    
    let minItemWidth: CGFloat = 100 // Define desired minimum width for an item.
    let gridSpacing: CGFloat = 10
    let screenWidth: CGFloat
    
    var body: some View {
        // LazyVGrid instead of a List for easy pagination
        LazyVGrid(columns: createGridColumns(forWidth: CGFloat(screenWidth), minItemWidth: minItemWidth, gridSpacing: gridSpacing), spacing: gridSpacing) {
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
        .id("Grid") // May need update when layout changes to correctly handle pagination.
        .padding(.horizontal, gridSpacing)
    }
    
    private func createGridColumns(forWidth screenWidth: CGFloat, minItemWidth: CGFloat, gridSpacing: CGFloat) -> [GridItem] {
        // Calculate the number of items per row based on the screen width, minimum item width, and spacing
        let totalSpacing: CGFloat = gridSpacing * 2 // Adjust this if needed to account for padding
        let availableWidth = screenWidth - totalSpacing
        let itemsPerRow = max(1, floor(availableWidth / (minItemWidth + gridSpacing)))
        
        var columns: [GridItem] = []
        for _ in 0..<Int(itemsPerRow) {
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

//
//  PopularHeaderView.swift
//  YassirMovies
//
//  Created by Pietro Messineo on 05/03/24.
//

import SwiftUI
import ModelPackage

struct PopularHeaderView: View {
    @EnvironmentObject var tmdbManager: TmdbManager
    @Binding var currentMovieList: DiscoverMovieList
    
    var body: some View {
        HStack {
            Text(currentMovieList.rawValue)
                .font(.system(size: 24, weight: .bold))
                .accessibilityIdentifier("popularContentLabel")
            
            Spacer()
            
            Menu {
                Button(action: {
                    currentMovieList = .popular
                }, label: {
                    Text("Popular")
                })
                .accessibilityIdentifier("popularFilterButton")
                
                Button(action: {
                    currentMovieList = .upcoming
                }, label: {
                    Text("Coming Soon")
                })
                .accessibilityIdentifier("upcomingFilterButton")
            } label: {
                Image(systemName: "line.3.horizontal.decrease.circle")
                    .font(.system(size: 30))
            }
            .foregroundStyle(Color.primary)
            .accessibilityIdentifier("menuFilter")
        }
        .padding(.horizontal, 16)
        .onChange(of: currentMovieList) { newMovieList in
            // Clear the current array and fetch new data
            Task {
                do {
                    tmdbManager.movieDiscoverList.removeAll()
                    try await tmdbManager.getMovieDiscover(page: 1, movieList: newMovieList)
                } catch {
                    print("Error getting movie discover \(error.localizedDescription)")
                }
            }
        }
    }
}

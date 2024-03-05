//
//  PopularHeaderView.swift
//  YassirMovies
//
//  Created by Pietro Messineo on 05/03/24.
//

import SwiftUI

struct PopularHeaderView: View {
    @EnvironmentObject var tmdbManager: TmdbManager
    @Binding var currentMovieList: DiscoverMovieList
    
    var body: some View {
        HStack {
            Text(currentMovieList.rawValue)
                .font(.system(size: 24, weight: .bold))
            
            Spacer()
            
            Menu {
                Button(action: {
                    currentMovieList = .popular
                }, label: {
                    Text("Popular")
                })
                
                Button(action: {
                    currentMovieList = .upcoming
                }, label: {
                    Text("Coming soon")
                })
            } label: {
                Image(systemName: "line.3.horizontal.decrease.circle")
                    .font(.system(size: 30))
            }
            .foregroundStyle(Color.primary)
        }
        .padding(.horizontal, 16)
        .onChange(of: currentMovieList) { newMovieList in
            // Clear the current array and fetch new data
            Task {
                do {
                    print("Update movie discover with \(newMovieList)")
                    tmdbManager.movieDiscoverList.removeAll()
                    try await tmdbManager.getMovieDiscover(page: 1, movieList: newMovieList)
                } catch {
                    print("Error getting movie discover \(error.localizedDescription)")
                }
            }
        }
    }
}

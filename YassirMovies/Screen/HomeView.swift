//
//  HomeView.swift
//  YassirMovies
//
//  Created by Pietro Messineo on 05/03/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var tmdbManager: TmdbManager
    
    var body: some View {
        ZStack {
            VStack {
                if let movieEditorsChoice = tmdbManager.movieEditorsChoice {
                    CarouselView(spacing: 20, items: movieEditorsChoice.compactMap({ movieItem in
                        return CoverFlowItem(item: movieItem)
                    })) { item in
                        CarouselItemView(item: item)
                    }
                    .frame(height: 200)
                }
                
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .task {
            do {
                try await tmdbManager.getMoviesEditorsChoice()
            } catch {
                print("Error fetching editors choice \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(TmdbManager())
}

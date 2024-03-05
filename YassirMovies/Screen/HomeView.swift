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
            
        }
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

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
        Text("Hello, World!")
    }
}

#Preview {
    HomeView()
        .environmentObject(TmdbManager())
}

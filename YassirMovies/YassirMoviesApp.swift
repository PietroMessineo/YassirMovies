//
//  YassirMoviesApp.swift
//  YassirMovies
//
//  Created by Pietro Messineo on 05/03/24.
//

import SwiftUI

@main
struct YassirMoviesApp: App {
    @StateObject var tmdbManager: TmdbManager = TmdbManager()
    
    var body: some Scene {
        WindowGroup {
            NavigationView(content: {
                HomeView()
            })
            .environmentObject(tmdbManager)
        }
    }
}

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
    @State var movieId: String?
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(root: {
                ZStack {
                    HomeView()
                }
            })
            .environmentObject(tmdbManager)
            .onOpenURL(perform: { url in
                handleURL(url)
            })
            .sheet(item: $movieId) { movieId in
                if let movieId = Int(movieId) {
                    MovieDetailView(movieId: movieId, posterImage: nil)
                        .environmentObject(tmdbManager)
                }
            }
        }
    }
    
    func handleURL(_ url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
              let host = components.host else {
            return
        }
        
        let path = components.path
        
        // Start with an empty string for id
        var id = ""
        
        // Extracting the ID from the path
        // Check if path contains more than just "/"
        if path.count > 1 {
            // Remove the leading "/" and get the eventual ID
            id = String(path.dropFirst())
        }
        
        switch host {
        case "movie":
            movieId = id
        default:
            print("Unknown URL")
        }
    }
}

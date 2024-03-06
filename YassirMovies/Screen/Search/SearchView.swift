//
//  SearchView.swift
//  YassirMovies
//
//  Created by Pietro Messineo on 06/03/24.
//

import SwiftUI
import Kingfisher

struct SearchView: View {
    @EnvironmentObject var tmdbManager: TmdbManager
    
    @State private var searchText: String = ""
    @State private var queryText: String = ""
    
    var body: some View {
        NavigationStack(root: {
            ZStack {
                Image("placeholderBkg")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                VStack {
                    List(tmdbManager.searchResults, id: \.self) { item in
                        if item.media_type == "movie" {
                            NavigationLink(
                                destination:
                                    MovieDetailView(movieId: item.id, posterImage: nil)
                                , label: {
                                    SearchItemView(item: item)
                                }
                            )
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                        } else {
                            SearchItemView(item: item)
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.clear)
                        }
                    }
                    .listStyle(.plain)
                    .searchable(text: $queryText, prompt: Text("Movies, Shows, Actors, Directors"))
                }
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.large)
            .onChange(of: queryText) { newQuery in
                if !queryText.isBlankOrEmpty() {
                    Task {
                        do {
                            try await tmdbManager.searchFor(query: newQuery)
                        }
                    }
                } else {
                    tmdbManager.searchResults.removeAll()
                }
            }
        })
    }
}

#Preview {
    NavigationStack {
        SearchView()
            .environmentObject(TmdbManager())
    }
}

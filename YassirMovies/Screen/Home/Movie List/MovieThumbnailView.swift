//
//  MovieThumbnailView.swift
//  YassirMovies
//
//  Created by Pietro Messineo on 05/03/24.
//

import SwiftUI
import ModelPackage

struct MovieThumbnailView: View {
    let item: Items
    
    var body: some View {
        if let imageUrl = item.poster_path, let url = URL(string: "https://image.tmdb.org/t/p/w500" + imageUrl) {
            AsyncImage(url: url) { image in
                NavigationLink(destination: MovieDetailView(movieId: item.id, posterImage: image) ) {
                    MovieItemView(image: image, item: item)
                }
            } placeholder: {
                RoundedRectangle(cornerRadius: 15)
                    .fill(.gray)
                    .overlay {
                        ProgressView()
                    }
                    .frame(width: 105, height: 156)
            }
        } else {
            NavigationLink(destination: MovieDetailView(movieId: item.id, posterImage: nil)) {
                MovieItemView(image: nil, item: item)
            }
        }
    }
}

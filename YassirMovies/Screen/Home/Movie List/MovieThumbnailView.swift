//
//  MovieThumbnailView.swift
//  YassirMovies
//
//  Created by Pietro Messineo on 05/03/24.
//

import SwiftUI
import Kingfisher

struct MovieThumbnailView: View {
    let item: Items
    
    var body: some View {
        if let imageUrl = item.poster_path, let url = URL(string: "https://image.tmdb.org/t/p/w500" + imageUrl) {
            let image = KFImage.url(url)
            
            NavigationLink(destination: MovieDetailView(movieId: item.id, posterImage: image) ) {
                MovieItemView(image: image, item: item)
            }
        } else {
            NavigationLink(destination: MovieDetailView(movieId: item.id, posterImage: nil)) {
                MovieItemView(image: nil, item: item)
            }
        }
    }
}

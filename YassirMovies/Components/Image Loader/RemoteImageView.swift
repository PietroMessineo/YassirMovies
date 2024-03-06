//
//  RemoteImageView.swift
//  YassirMovies
//
//  Created by Pietro Messineo on 06/03/24.
//

import SwiftUI

// Wrapper that can be reused to pull images from TMDB database
struct RemoteImageView: View {
    let imagePath: String?
    
    var body: some View {
        // Check if image is not nil, if not append to base path and return imageView
        // NOTE: AsyncImage should be replaced with cached objects in prod
        // Trying to avoid dependencies as much as possible
        if let imagePath = imagePath, let url = URL(string: "https://image.tmdb.org/t/p/w500" + imagePath) {
            AsyncImage(url: url) { image in
                imageView(for: image)
            } placeholder: {
                ProgressView()
            }
        } else {
            placeholderImage
        }
    }
    
    @ViewBuilder
    private func imageView(for image: Image) -> some View {
            image
                .resizable()
                .scaledToFill()
    }
    
    private var placeholderImage: some View {
        Image("placeholder")
            .resizable()
    }
}

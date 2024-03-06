//
//  RemoteImageView.swift
//  YassirMovies
//
//  Created by Pietro Messineo on 06/03/24.
//

import SwiftUI
import Kingfisher

struct RemoteImageView: View {
    let imagePath: String?
    
    var body: some View {
        if let imagePath = imagePath, let url = URL(string: "https://image.tmdb.org/t/p/w500" + imagePath) {
            let image = KFImage.url(url)
                .placeholder({ progress in
                    ProgressView()
                })
            imageView(for: image)
        } else {
            placeholderImage
        }
    }
    
    @ViewBuilder
    private func imageView(for image: KFImage) -> some View {
            image
                .resizable()
                .scaledToFill()
    }
    
    private var placeholderImage: some View {
        Image("placeholder")
            .resizable()
    }
}

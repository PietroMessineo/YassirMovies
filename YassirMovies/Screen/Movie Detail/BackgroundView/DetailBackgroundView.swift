//
//  BackgroundView.swift
//  YassirMovies
//
//  Created by Pietro Messineo on 05/03/24.
//

import SwiftUI
import Kingfisher

struct DetailBackgroundView: View {
    @EnvironmentObject var tmdbManager: TmdbManager
    let posterImage: KFImage?
    
    var body: some View {
        GeometryReader(content: { geometry in
            if let posterImage = posterImage {
                posterImage
                    .resizable()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .blur(radius: 60)
                    .opacity(0.75)
                
            } else if let imageUrl = tmdbManager.movieDetails?.poster_path, let url = URL(string: "https://image.tmdb.org/t/p/w500" + imageUrl) {
                KFImage.url(url)
                    .placeholder({ progress in
                        ProgressView()
                    })
                    .resizable()
                    .frame(width: geometry.size.width, height: .infinity)
                    .blur(radius: 60)
                    .opacity(0.75)
            } else {
                Image("placeholder")
                    .resizable()
                    .frame(width: geometry.size.width, height: .infinity)
                    .blur(radius: 60)
                    .opacity(0.75)
            }
        })
    }
}

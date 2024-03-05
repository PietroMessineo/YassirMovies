//
//  MoviePosterImageView.swift
//  YassirMovies
//
//  Created by Pietro Messineo on 05/03/24.
//

import SwiftUI
import Kingfisher

struct MoviePosterImageView: View {
    @EnvironmentObject var tmdbManager: TmdbManager
    let posterImage: KFImage?
    let screenWidth: CGFloat
    @Binding var shouldCollapse: Bool
    
    var body: some View {
        if let posterImage = posterImage {
            posterImage
                .resizable()
                .scaledToFill()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(shouldCollapse ? 10 : 20)
                .padding(EdgeInsets(top: 25, leading: shouldCollapse ? 20 : screenWidth / 3, bottom: shouldCollapse ? 20 : 0, trailing: shouldCollapse ? 0 : screenWidth / 3))
                .frame(width: shouldCollapse ? 100 : nil)
            
        } else if let imageUrl = tmdbManager.movieDetails?.poster_path, let url = URL(string: "https://image.tmdb.org/t/p/w500" + imageUrl) {
            KFImage.url(url)
                .resizable()
                .scaledToFill()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(shouldCollapse ? 10 : 20)
                .padding(EdgeInsets(top: 25, leading: shouldCollapse ? 20 : screenWidth / 3, bottom: shouldCollapse ? 20 : 0, trailing: shouldCollapse ? 0 : screenWidth / 3))
                .frame(width: shouldCollapse ? 100 : nil)
        } else {
            Image("placeholder")
                .resizable()
                .scaledToFill()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(shouldCollapse ? 10 : 20)
                .padding(EdgeInsets(top: 25, leading: shouldCollapse ? 20 : screenWidth / 3, bottom: shouldCollapse ? 20 : 0, trailing: shouldCollapse ? 0 : screenWidth / 3))
                .frame(width: shouldCollapse ? 100 : nil)
        }
    }
}

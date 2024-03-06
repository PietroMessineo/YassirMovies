//
//  MoviePosterImageView.swift
//  YassirMovies
//
//  Created by Pietro Messineo on 05/03/24.
//

import SwiftUI
import ComponentsPackage
import ModelPackage

struct MoviePosterImageView: View {
    @EnvironmentObject var tmdbManager: TmdbManager
    let posterImage: Image?
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
            
        } else {
            RemoteImageView(imagePath: tmdbManager.movieDetails?.poster_path)
                .scaledToFill()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(shouldCollapse ? 10 : 20)
                .padding(EdgeInsets(top: 25, leading: shouldCollapse ? 20 : screenWidth / 3, bottom: shouldCollapse ? 20 : 0, trailing: shouldCollapse ? 0 : screenWidth / 3))
                .frame(width: shouldCollapse ? 100 : nil)
        }
    }
}

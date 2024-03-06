//
//  BackgroundView.swift
//  YassirMovies
//
//  Created by Pietro Messineo on 05/03/24.
//

import SwiftUI
import ComponentsPackage

struct DetailBackgroundView: View {
    @EnvironmentObject var tmdbManager: TmdbManager
    let posterImage: Image?
    
    var body: some View {
        GeometryReader(content: { geometry in
            if let posterImage = posterImage {
                posterImage
                    .resizable()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .blur(radius: 60)
                    .opacity(0.75)
                
            } else {
                RemoteImageView(imagePath: tmdbManager.movieDetails?.poster_path)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .blur(radius: 60)
                    .opacity(0.75)
            }
        })
    }
}

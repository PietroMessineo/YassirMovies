//
//  MovieInfoView.swift
//  YassirMovies
//
//  Created by Pietro Messineo on 05/03/24.
//

import SwiftUI

struct MovieDetailInfoView: View {
    @EnvironmentObject var tmdbManager: TmdbManager
    @State var isDescriptionExpanded: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            if let overview = tmdbManager.movieDetails?.overview {
                VStack(alignment: .leading) {
                    Text(overview)
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 17, weight: .medium))
                        .foregroundColor(.white)
                        .lineLimit(isDescriptionExpanded ? nil : 4)
                    
                    Text(!isDescriptionExpanded ? "more" : "less")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.white)
                }
                .onTapGesture {
                    isDescriptionExpanded.toggle()
                }
                .padding(EdgeInsets(top: 20, leading: 38, bottom: 0, trailing: 32))
            }
            createReleaseDateText()
        }
    }
    
    func createReleaseDateText() -> some View {
        if let releaseDate = tmdbManager.movieDetails?.release_date {
            return AnyView(
                VStack(alignment: .leading) {
                    Text(releaseDate.getReleaseStatus())
                        .font(.system(size: 17, weight: .medium))
                        .foregroundColor(.white)
                        .opacity(0.5)
                        .multilineTextAlignment(.leading)
                        .padding(.top, 4)
                        .padding(.leading, 38)
                    if let runtime = tmdbManager.movieDetails?.runtime, runtime != 0 {
                        Text("\(runtime) minutes")
                            .font(.system(size: 17, weight: .medium))
                            .foregroundColor(.white)
                            .opacity(0.5)
                            .multilineTextAlignment(.leading)
                            .padding(.leading, 38)
                    }
                }
                    .padding(.bottom, 30)
            )
        }
        return AnyView(EmptyView())
    }
}

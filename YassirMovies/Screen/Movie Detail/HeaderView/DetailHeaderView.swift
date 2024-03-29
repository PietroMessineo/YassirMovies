//
//  DetailHeaderView.swift
//  YassirMovies
//
//  Created by Pietro Messineo on 05/03/24.
//

import SwiftUI
import ModelPackage

struct DetailHeaderView: View {
    @EnvironmentObject var tmdbManager: TmdbManager
    @Binding var shouldCollapse: Bool
    
    // Screen width which is passed from GeometryReader is being used for calculate dynamically the horizontal spacing
    let screenWidth: CGFloat
    let posterImage: Image?
    
    var body: some View {
        VStack {
            HStack {
                MoviePosterImageView(posterImage: posterImage, screenWidth: screenWidth, shouldCollapse: $shouldCollapse)
                
                if shouldCollapse {
                    createTitleAndReleaseStatusVStack()
                    Spacer()
                }
            }
            
            HStack {
                Spacer()
                createTitleAndReleaseStatusVStack()
                Spacer()
            }
            .padding(.top, shouldCollapse ? -100 : nil)
            .opacity(shouldCollapse ? 0 : 1)
            .animation(.easeOut(duration: 0.3), value: shouldCollapse)
        }
    }
    
    func createTitleAndReleaseStatusVStack() -> some View {
        VStack(alignment: shouldCollapse ? .leading : .center) {
            Text(tmdbManager.movieDetails?.original_title ?? "")
                .font(.system(size: shouldCollapse ? 17 : 22, weight: shouldCollapse ? .semibold : .bold))
                .foregroundColor(.white)
                .multilineTextAlignment(shouldCollapse ? .leading : .center)
            
            if let releaseDate = tmdbManager.movieDetails?.release_date {
                Text(releaseDate.getReleaseStatus())
                    .font(.system(size: shouldCollapse ? 17 : 22, weight: shouldCollapse ? .semibold : .bold))
                    .foregroundColor(.white)
                    .opacity(0.5)
            }
        }
    }
}



//
//  CastView.swift
//  YassirMovies
//
//  Created by Pietro Messineo on 05/03/24.
//

import SwiftUI
import ModelPackage

struct CastView: View {
    @EnvironmentObject var tmdbManager: TmdbManager
    
    let credits = ["Cast", "Crew"]
    
    var body: some View {
        ForEach(credits, id: \.self) { credit in
            createDisclosureGroup(for: credit)
        }
        .padding(EdgeInsets(top: -20, leading: 38, bottom: 0, trailing: 18))
    }
    
    func createDisclosureGroup(for credit: String) -> some View {
        DisclosureGroup {
            if credit == "Cast" {
                createCastList()
            } else if credit == "Crew" {
                createCrewList()
            }
        } label: {
            Text(credit)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.white)
                .padding(.bottom, 28)
                .padding(.top, 16)
        }
    }
    
    func createCastList() -> some View {
        if tmdbManager.movieDetails?.credits?.cast?.isEmpty == true {
            return AnyView(
                Text("No cast info available")
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(.white)
            )
        } else {
            return AnyView(
                ForEach(tmdbManager.movieDetails?.credits?.cast ?? [], id: \.id) { cast in
                    createCastRow(cast: cast)
                }
            )
        }
    }
    
    func createCrewList() -> some View {
        if tmdbManager.movieDetails?.credits?.crew?.isEmpty == true {
            return AnyView(
                Text("No crew info available")
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(.white)
            )
        } else {
            return AnyView(
                ForEach(tmdbManager.movieDetails?.credits?.crew ?? [], id: \.id) { cast in
                    createCastRow(cast: cast)
                }
            )
        }
    }
    
    func createCastRow(cast: Person) -> some View {
        HStack {
            PersonItemView(cast: cast, imagePath: cast.profile_path)
            Spacer()
        }
    }
}

#Preview {
    MovieDetailView(movieId: 1028703, posterImage: nil)
        .environmentObject(TmdbManager())
}

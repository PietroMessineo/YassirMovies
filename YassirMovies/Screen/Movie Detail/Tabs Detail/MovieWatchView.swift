//
//  MovieWatchView.swift
//  YassirMovies
//
//  Created by Pietro Messineo on 05/03/24.
//

import SwiftUI
import Kingfisher

struct MovieWatchView: View {
    @EnvironmentObject var tmdbManager: TmdbManager
    
    var body: some View {
        guard let currentLocaleIdentifier = Locale.current.region?.identifier, let watchProviders = tmdbManager.movieWatchProviders[currentLocaleIdentifier]
            else { return AnyView(emptyTextView()) }
        
        // Combine different provider categories with subtitles
        let providers = [
            setSubtitle(providers: watchProviders.buy, subtitle: "Buy"),
            setSubtitle(providers: watchProviders.flatrate, subtitle: "Streaming"),
            setSubtitle(providers: watchProviders.rent, subtitle: "Rent")
        ].flatMap { $0 }
        
        if providers.isEmpty {
            return AnyView(emptyTextView())
        } else {
            return AnyView(createProviderListView(providers: providers))
        }
    }
    
    func createProviderListView(providers: [Provider]) -> some View {
        VStack(alignment: .leading) {
            ForEach(providers) { provider in
                HStack {
                    createImageRow(provider: provider)
                    VStack(alignment: .leading) {
                        Text(provider.providerName)
                            .font(.system(size: 17, weight: .bold))
                            .foregroundColor(.white)
                        Text(provider.subtitle ?? "")
                            .font(.system(size: 17, weight: .medium))
                            .foregroundColor(.white)
                            .opacity(0.5)
                    }
                    Spacer()
                }.padding(.leading, 23)
            }
        }
    }
    
    func setSubtitle(providers: [Provider]?, subtitle: String) -> [Provider] {
        providers?.map { var provider = $0; provider.subtitle = subtitle; return provider } ?? []
    }
    
    func createImageRow(provider: Provider) -> some View {
        let imageUrl = "https://image.tmdb.org/t/p/w500" + (provider.logoPath)
        return KFImage.url(URL(string: imageUrl))
            .resizable()
            .scaledToFill()
            .frame(width: 72, height: 72)
            .clipShape(Circle())
    }
    
    func emptyTextView() -> some View {
        HStack {
            Spacer()
            Text("This movie is currently playing in theatres, or not available yet.")
                .font(.system(size: 17, weight: .medium))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.top, 200)
            Spacer()
        }
    }
}

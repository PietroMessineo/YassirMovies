//
//  BackdropOverlayView.swift
//  YassirMovies
//
//  Created by Pietro Messineo on 05/03/24.
//

import SwiftUI
import Kingfisher

struct BackdropOverlayView: View {
    let item: CoverFlowItem
    
    var body: some View {
        VStack {
            Spacer()
            if let image = item.item.poster_path, let url = URL(string: "https://image.tmdb.org/t/p/w500\(image)") {
                HStack {
                    KFImage(url)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 80)
                        .shadow(radius: 3)
                        .cornerRadius(6)
                    
                    VStack(alignment: .leading) {
                        if let title = item.item.original_title {
                            Text(title)
                                .font(.system(size: 14, weight: .bold))
                                .shadow(color: .black, radius: 1)
                                .multilineTextAlignment(.leading)
                        }
                        if let releaseStatus = item.item.release_date?.getReleaseStatus() {
                            Text(releaseStatus)
                                .font(.system(size: 14, weight: .bold))
                                .shadow(color: .black, radius: 1)
                        }
                    }
                }
                .foregroundStyle(.white)
            }
        }
        .padding(10)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
    }
}
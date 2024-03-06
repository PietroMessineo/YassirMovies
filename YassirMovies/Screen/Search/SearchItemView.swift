//
//  SearchItemView.swift
//  YassirMovies
//
//  Created by Pietro Messineo on 06/03/24.
//

import SwiftUI

struct SearchItemView: View {
    let item: SearchResult
    
    var body: some View {
        HStack {
            if item.media_type == "person" {
                RemoteImageView(imagePath: item.profile_path)
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
            } else {
                RemoteImageView(imagePath: item.poster_path)
                    .frame(width: 64, height: 96)
                    .cornerRadius(10)
            }
            
            VStack(alignment: .leading) {
                Text(item.name ?? item.title ?? "-")
                    .font(.system(size: 17, weight: .medium))
                    .padding(.bottom, 0)
                if item.media_type == "person" {
                    Text(item.known_for_department ?? "")
                        .font(.system(size: 17, weight: .medium))
                        .foregroundColor(.white.opacity(0.5))
                } else {
                    if let releaseStatus = item.first_air_date?.getReleaseStatus() ?? item.release_date?.getReleaseStatus() {
                        Text(releaseStatus)
                            .font(.system(size: 17, weight: .medium))
                            .foregroundColor(.white.opacity(0.5))
                    }
                }
            }
        }
    }
}

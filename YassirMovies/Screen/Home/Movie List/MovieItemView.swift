//
//  MovieItemView.swift
//  YassirMovies
//
//  Created by Pietro Messineo on 05/03/24.
//

import SwiftUI
import Kingfisher

struct MovieItemView: View {
    let image: KFImage?
    let item: Items
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                if let image {
                    image
                        .resizable()
                        .frame(width: 105, height: 156)
                        .cornerRadius(15)
                        .overlay(releaseStatusLabel())
                } else {
                    Image("placeholder")
                        .resizable()
                        .frame(width: 105, height: 156)
                        .cornerRadius(15)
                        .overlay(releaseStatusLabel())
                }
            }
            Spacer(minLength: 20)
        }
    }
    
    private func releaseStatusLabel() -> some View {
        VStack {
            let releaseStatus = item.release_date?.getReleaseStatus()
            Spacer()
            if releaseStatus != "Released" {
                Text(releaseStatus ?? "")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.primary)
                    .padding(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
                    .frame(maxWidth: .infinity)
                    .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 20))
            }
        }
        .padding(EdgeInsets(top: 0, leading: 8, bottom: 8, trailing: 8))
    }
}

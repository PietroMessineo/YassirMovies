//
//  BackdropOverlayView.swift
//  YassirMovies
//
//  Created by Pietro Messineo on 05/03/24.
//

import SwiftUI

struct BackdropOverlayView: View {
    let item: CoverFlowItem
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                RemoteImageView(imagePath: item.item.poster_path)
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
        .padding(10)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
    }
}

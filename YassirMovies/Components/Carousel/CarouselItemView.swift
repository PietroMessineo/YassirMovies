//
//  CarouselItemView.swift
//  YassirMovies
//
//  Created by Pietro Messineo on 05/03/24.
//

import SwiftUI
import Kingfisher

struct CarouselItemView: View {
    let item: CoverFlowItem
    
    var body: some View {
        Group {
            if let image = item.item.backdrop_path, let url = URL(string: "https://image.tmdb.org/t/p/w500\(image)") {
                KFImage(url)
                    .resizable()
                    .scaledToFill()
                    .frame(width: getCardWidth(), height: getCardHeight())
                    .cornerRadius(20)
                    .overlay {
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
            } else {
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: getCardWidth(), height: getCardHeight())
            }
        }
    }
    
    func getCardWidth() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let widthRatio: CGFloat = 290 / 430
        let calculatedWidth = screenWidth * widthRatio
        
        return calculatedWidth
    }

    func getCardHeight() -> CGFloat {
        let cardWidth = getCardWidth()
        let heightRatio: CGFloat = 160 / 290
        let calculatedHeight = cardWidth * heightRatio
        
        return calculatedHeight
    }
}

#Preview {
    HomeView()
        .environmentObject(TmdbManager())
}

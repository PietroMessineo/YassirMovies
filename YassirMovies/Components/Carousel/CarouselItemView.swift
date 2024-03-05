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
                        BackdropOverlayView(item: item)
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

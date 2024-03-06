//
//  CarouselItemView.swift
//  YassirMovies
//
//  Created by Pietro Messineo on 05/03/24.
//

import SwiftUI

struct CarouselItemView: View {
    let item: CoverFlowItem
    
    var body: some View {
        Group {
            RemoteImageView(imagePath: item.item.backdrop_path)
                .scaledToFill()
                .frame(width: getCardWidth(), height: getCardHeight())
                .cornerRadius(20)
                .overlay {
                    BackdropOverlayView(item: item)
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

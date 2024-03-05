//
//  CarouselView.swift
//  YassirMovies
//
//  Created by Pietro Messineo on 05/03/24.
//

import SwiftUI

struct CarouselView<Content: View, Item: RandomAccessCollection>: View where Item.Element: Identifiable {
    var spacing: CGFloat = 0
    var items: Item
    var content: (Item.Element) -> Content
    var body: some View {
        GeometryReader {
            let size = $0.size
            ScrollViewReader { scrollViewProxy in
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 0) {
                        ForEach(items) { item in
                            content(item)
                                .frame(width: getCardWidth())
                                .padding(.trailing, item.id == items.last?.id ? 0 : spacing)
                        }
                    }
                    .padding(.horizontal, (size.width - getCardWidth()) / 2)
                    .onAppear {
                        if let secondItemId = items.dropFirst().first?.id {
                            scrollViewProxy.scrollTo(secondItemId, anchor: .center)
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
    }

    func getCardWidth() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let widthRatio: CGFloat = 290 / 430
        let calculatedWidth = screenWidth * widthRatio
        return calculatedWidth
    }
}

struct CoverFlowItem: Identifiable {
    let id: UUID = .init()
    var item: Items
}

#Preview {
    HomeView()
        .environmentObject(TmdbManager())
}

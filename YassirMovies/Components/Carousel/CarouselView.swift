//
//  CarouselView.swift
//  YassirMovies
//
//  Created by Pietro Messineo on 05/03/24.
//

import SwiftUI

struct CarouselView<Content: View, Item: RandomAccessCollection>: View where Item.Element: Identifiable {
    var itemWidth: CGFloat
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
                                .frame(width: itemWidth)
                                .padding(.trailing, item.id == items.last?.id ? 0 : spacing)
                        }
                    }
                    .padding(.horizontal, (size.width - itemWidth) / 2)
                    .onAppear {
                        if let secondItemId = items.dropFirst().first?.id {
                            scrollViewProxy.scrollTo(secondItemId, anchor: .leading)
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
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

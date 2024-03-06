//
//  CarouselView.swift
//  YassirMovies
//
//  Created by Pietro Messineo on 05/03/24.
//

import SwiftUI
import ModelPackage

// A generic carousel view that can display any kind of view (Content) for a given collection of items (Item).
struct CarouselView<Content: View, Item: RandomAccessCollection>: View where Item.Element: Identifiable {
    var spacing: CGFloat = 0 // Spacing between individual items in the carousel.
    var items: Item // The collection of items that the carousel will display.
    var content: (Item.Element) -> Content // A closure that takes an item from the collection and returns a view for that item.
    
    // The body of the CarouselView, responsible for laying out the content.
    var body: some View {
        GeometryReader { geometryProxy in
            let size = geometryProxy.size
            // ScrollViewReader and ScrollView nested are needed in order to automatically scroll to the second item automatically
            ScrollViewReader { scrollViewProxy in
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 0) {
                        ForEach(items) { item in
                            content(item)
                                .frame(width: getCardWidth())
                                // Conditional padding to remove trailing space on the last item.
                                .padding(.trailing, item.id == items.last?.id ? 0 : spacing)
                        }
                    }
                    // Center the first item initially by adding equal padding on both sides.
                    .padding(.horizontal, (size.width - getCardWidth()) / 2)
                    .onAppear {
                        // Auto-scroll to the second item
                        if let secondItemId = items.dropFirst().first?.id {
                            scrollViewProxy.scrollTo(secondItemId, anchor: .center)
                        }
                    }
                }
                .scrollIndicators(.hidden) // Hide the scroll bar indicators for a cleaner look.
            }
        }
    }

    // Determine the width of the cards based on screen width to maintain a consistent aspect ratio.
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

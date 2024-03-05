//
//  ButtonCategoryView.swift
//  YassirMovies
//
//  Created by Pietro Messineo on 05/03/24.
//

import SwiftUI

struct ButtonDetailTabView: View {
    let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .medium)
    
    @Binding var selectedTab: MovieDetailTab
    @Binding var shouldCollapse: Bool
    let currentTab: MovieDetailTab
    
    var body: some View {
        Button(action: {
            withAnimation {
                impactFeedbackgenerator.prepare()
                impactFeedbackgenerator.impactOccurred()
                if selectedTab == currentTab {
                    selectedTab = .none
                    shouldCollapse = false
                } else {
                    selectedTab = currentTab
                    shouldCollapse = true
                }
            }
        }) {
            HStack {
                Image(systemName: currentTab == .cast ? "person.2.fill" : currentTab == .watch ? "ticket.fill" : "play.fill")
                    .font(.system(size: 17, weight: .medium))
                    .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 0))
                
                Text(currentTab.rawValue)
                    .font(.system(size: 17, weight: .semibold))
                    .padding(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 15))
            }
        }
        .foregroundColor(.white)
        .background(Color(red: 51/255, green: 51/255, blue: 51/255).blendMode(.screen))
        .cornerRadius(20)
        .overlay {
            RoundedRectangle(cornerRadius: 24).strokeBorder(selectedTab == currentTab ? Color.white.blendMode(.normal) : Color.clear.blendMode(.luminosity), lineWidth: 3).padding(-4)
        }
    }
}


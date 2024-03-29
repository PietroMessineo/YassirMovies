//
//  PersonItemView.swift
//  YassirMovies
//
//  Created by Pietro Messineo on 05/03/24.
//

import SwiftUI
import ComponentsPackage
import ModelPackage

struct PersonItemView: View {
    let cast: Person
    let imagePath: String?
    var body: some View {
        RemoteImageView(imagePath: imagePath)
            .scaledToFill()
            .frame(width: 60, height: 60)
            .clipShape(Circle())
        
        VStack(alignment: .leading) {
            Text(cast.name ?? "")
                .fontWeight(.bold)
                .foregroundColor(.white)
            if let character = cast.character, character != "" {
                Text(character)
                    .foregroundColor(.white)
                    .opacity(0.5)
                    .multilineTextAlignment(.leading)
            } else if let department = cast.known_for_department, department != "" {
                Text(department)
                    .foregroundColor(.white)
                    .opacity(0.5)
                    .multilineTextAlignment(.leading)
            }
        }
    }
}

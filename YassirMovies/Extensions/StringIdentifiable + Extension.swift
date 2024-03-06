//
//  StringIdentifiable + Extension.swift
//  YassirMovies
//
//  Created by Pietro Messineo on 06/03/24.
//

import Foundation

// Used in order to observe onChange when using a String
extension String: Identifiable {
    public typealias ID = Int
    public var id: Int {
        return hash
    }
}

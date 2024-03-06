//
//  StringIdentifiable + Extension.swift
//  YassirMovies
//
//  Created by Pietro Messineo on 06/03/24.
//

import Foundation

extension String: Identifiable {
    public typealias ID = Int
    public var id: Int {
        return hash
    }
}

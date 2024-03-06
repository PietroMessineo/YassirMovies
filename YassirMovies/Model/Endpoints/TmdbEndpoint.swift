//
//  TmdbEndpoint.swift
//  YassirMovies
//
//  Created by Pietro Messineo on 05/03/24.
//

import Foundation

enum TmdbEndpoint {
    case editorsChoice
    case getMovieDetails(id: String)
    case getMovieDiscover(page: Int, movieList: DiscoverMovieList)
    case searchFor(query: String)
    case getWatchProviders(movieId: String)
}

extension TmdbEndpoint: Endpoint {
    var queryItems: [URLQueryItem]? {
        switch self {
        case .editorsChoice:
            return nil
        case .getMovieDetails:
            let region = Locale.current.region?.identifier
            return [
                URLQueryItem(name: "region", value: region),
                URLQueryItem(name: "with_release_type", value: "3"),
                URLQueryItem(name: "append_to_response", value: "release_dates,videos,credits")
            ]
        case .getMovieDiscover(let page, let movieList):
            let region = Locale.current.region?.identifier
            
            var defaultQueries = [
                URLQueryItem(name: "region", value: region),
                URLQueryItem(name: "include_adult", value: "false"),
                URLQueryItem(name: "include_video", value: "false"),
                URLQueryItem(name: "page", value: "\(page)")
            ]
            
            if movieList == .upcoming {
                defaultQueries.append(URLQueryItem(name: "with_release_type", value: "3"))
                defaultQueries.append(URLQueryItem(name: "sort_by", value: "popularity.desc"))
                defaultQueries.append(URLQueryItem(name: "release_date.gte", value: Date().todaysFormattedDate()))
                defaultQueries.append(URLQueryItem(name: "release_date.lte", value: Date().nextYearFormattedDate()))
            } else if movieList == .popular {
                defaultQueries.append(URLQueryItem(name: "sort_by", value: "popularity.desc"))
            }
            
            return defaultQueries
        case .searchFor(let query):
            let region = Locale.current.region?.identifier
            return [
                URLQueryItem(name: "region", value: region),
                URLQueryItem(name: "page", value: "1"),
                URLQueryItem(name: "include_adult", value: "false"),
                URLQueryItem(name: "query", value: query)
            ]
        case .getWatchProviders:
            return nil
        }
    }
    
    var path: String {
        switch self {
        case .editorsChoice:
            return "/3/list/8293039"
        case .getMovieDetails(let id):
            return "/3/movie/\(id)"
        case .getMovieDiscover:
            return "/3/discover/movie"
        case .searchFor:
            return "/3/search/multi"
        case .getWatchProviders(let movieId):
            return "/3/movie/\(movieId)/watch/providers"
        }
    }

    var method: RequestMethod {
        switch self {
        case .editorsChoice:
            return .get
        case .getMovieDetails:
            return .get
        case .getMovieDiscover:
            return .get
        case .searchFor:
            return .get
        case .getWatchProviders:
            return .get
        }
    }

    var header: [String: String]? {
        switch self {
        case .editorsChoice:
            return nil
        case .getMovieDetails:
            return nil
        case .getMovieDiscover:
            return nil
        case .searchFor:
            return nil
        case .getWatchProviders:
            return nil
        }
    }
    
    var body: [String: Any]? {
        switch self {
        case .editorsChoice:
            return nil
        case .getMovieDetails:
            return nil
        case .getMovieDiscover:
            return nil
        case .searchFor:
            return nil
        case .getWatchProviders:
            return nil
        }
    }
}

enum DiscoverMovieList: String {
    case popular = "Popular"
    case upcoming = "Coming soon"
}

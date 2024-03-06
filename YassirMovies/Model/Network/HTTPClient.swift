//
//  HTTPClient.swift
//  YassirMovies
//
//  Created by Pietro Messineo on 05/03/24.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: Any]? { get }
    var queryItems: [URLQueryItem]? { get }
}

enum RequestMethod: String {
    case delete = "DELETE"
    case get = "GET"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
}

extension Endpoint {
    var scheme: String {
        return "https"
    }

    var host: String {
        return "api.themoviedb.org"
    }
}

protocol HTTPClient {
    func request<T: Decodable>(endpoint: Endpoint, responseModel: T.Type, decoder: JSONDecoder?) async throws -> T
}

extension HTTPClient {
    private var apiToken: String {
        return "ae7efbeb3042a1c9747a463a463af76d"
    }
    
    private var language: String {
        let locale = Locale.current
        let language = "\(locale.language.languageCode?.identifier ?? "EN")-\(locale.region?.identifier ?? "US")"
        return language
    }
    
    func request<T: Decodable>(
        endpoint: Endpoint,
        responseModel: T.Type,
        decoder: JSONDecoder? = JSONDecoder()
    ) async throws -> T {
        var defaultQueryItems: [URLQueryItem] = [
            URLQueryItem(name: "api_key", value: apiToken),
            URLQueryItem(name: "language", value: language)
        ]
        
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        
        if let queryItems = endpoint.queryItems {
            defaultQueryItems.append(contentsOf: queryItems)
        }
        
        urlComponents.queryItems = defaultQueryItems

        guard let url = urlComponents.url else {
            throw RequestError.invalidURL
        }
        
        var request = URLRequest(url: url)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Methods and headers
        request.httpMethod = endpoint.method.rawValue

        if let body = endpoint.body {
            if let jsonData = endpoint.body?["jsonData"] as? Data {
                request.httpBody = jsonData
            } else {
                request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
            }
        }
        
        let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
        
        guard let response = response as? HTTPURLResponse else {
            throw RequestError.noResponse
        }
        
        switch response.statusCode {
        case 200 ... 299:
            do {
                return try decoder!.decode(responseModel, from: data)
            }  catch {
                throw RequestError.decode
            }
        case 401:
            throw RequestError.unauthorized
        case 400, 404, 500:
            do {
                return try decoder!.decode(responseModel, from: data)
            } catch {
                throw RequestError.decode
            }
        default:
            throw RequestError.unexpectedStatusCode
        }
    }
}

enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown

    var customMessage: String {
        switch self {
        case .decode:
            return "Decode error"
        case .unauthorized:
            return "Session expired"
        default:
            return "Unknown error"
        }
    }
}

//
//  EndPoints.swift
//  GithubUsers
//
//  Created by bakhirev on 29/05/2019.
//  Copyright © 2019 None. All rights reserved.
//

import Foundation

enum Endpoint {
    static let scheme = "https"
    static let host = "dictionary.skyeng.ru"
    
    case search(page: Int, searchText: String)

    var path: String {
        switch self {
        case .search:
            return "/api/public/v1/words/search"
        }
    }
    
    static func url(for urlString: String) -> URL? {
        return URL(string: scheme + ":" + urlString)
    }
    
}

extension Endpoint: RequestParameters {
    var url: URL? {
        var components = URLComponents()
        components.scheme = Endpoint.scheme
        components.host = Endpoint.host
        components.path = path
        components.queryItems = queryItems
        return components.url
    }

    var method: HTTPMethod {
        return .get
    }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .search(let page, let searchText):
            return [
                URLQueryItem(name: "search", value: searchText),
                URLQueryItem(name: "page", value: String(page)),
                URLQueryItem(name: "pageSize", value: "20")
            ]
        }
    }
}

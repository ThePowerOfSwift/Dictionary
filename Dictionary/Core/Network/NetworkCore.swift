//
//  NetworkCore.swift
//  GithubUsers
//
//  Created by bakhirev on 29/05/2019.
//  Copyright © 2019 None. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "get"
    case post = "post"
    case patch = "patch"
    case delete = "delete"
}

struct NetworkResponse {
    let response: URLResponse?
    let data: Data?
}

protocol RequestParameters {
    var url: URL? { get }
    var method: HTTPMethod { get }
}

protocol Network {
    func performRequest(
        parameters: RequestParameters,
        completion: @escaping (Result<NetworkResponse, Error>) -> ()
    ) -> URLSessionTask?
}

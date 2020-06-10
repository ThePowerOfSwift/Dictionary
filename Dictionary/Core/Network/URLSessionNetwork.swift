//
//  URLSessionNetwork.swift
//  GithubUsers
//
//  Created by bakhirev on 29/05/2019.
//  Copyright © 2019 None. All rights reserved.
//

import Foundation

class URLSessionNetwork: Network {
    func performRequest(
        parameters: RequestParameters,
        completion: @escaping (Result<NetworkResponse, Error>) -> ()
        ) -> URLSessionTask? {
        guard let url = parameters.url else {
            let error = NSError(domain: "invalid url", code: 0, userInfo: nil)
            completion(.failure(error))
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = parameters.method.rawValue
        request.allHTTPHeaderFields = ["accept": "application/json"]

        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request, completionHandler: {data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            let response = NetworkResponse(response: response, data: data)
            completion(.success(response))
        })
        task.resume()
        return task
    }
}

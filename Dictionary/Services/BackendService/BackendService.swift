//
//  BackendService.swift
//  GithubUsers
//
//  Created by bakhirev on 29/05/2019.
//  Copyright © 2019 None. All rights reserved.
//

import UIKit

protocol BackendService {
    func request<Model: Codable>(
        endpoint: Endpoint,
        for model: Model.Type,
        completion: @escaping (Result<Model, Error>) -> Void)
}

class BackendServiceImplementation: BackendService {
    let network: Network

    init(network: Network) {
        self.network = network
    }

    func request<Model>(
        endpoint: Endpoint,
        for model: Model.Type,
        completion: @escaping (Result<Model, Error>) -> Void) where Model : Decodable, Model : Encodable {
        _ = network.performRequest(parameters: endpoint, completion: { result in
            switch result {
            case .success(let response):
                let s = String(data: response.data!, encoding: .utf8)!
                print(s)
                if let data = response.data,
                    let object = try? JSONDecoder().decode(model, from: data) {
                    completion(.success(object))
                } else {
                    let error = NSError(domain: "error", code: 0, userInfo: nil)
                    completion(.failure(error))
                }

            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}

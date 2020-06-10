//
//  BackendServiceFactory.swift
//  GithubUsers
//
//  Created by bakhirev on 01/06/2019.
//  Copyright © 2019 None. All rights reserved.
//

import Foundation

protocol BackendServiceFactory {
    static func createBackendService() -> BackendService
}

extension DependencyContainer: BackendServiceFactory {
    static func createBackendService() -> BackendService {
        return BackendServiceImplementation(network: network)
    }
}

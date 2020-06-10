//
//  DictionaryServiceFactory.swift
//  Dictionary
//
//  Created by Bakhirev on 08.06.2020.
//  Copyright © 2020 Bakhirev. All rights reserved.
//

import Foundation

protocol DictionaryServiceFactory {
    static func createDictionaryService() -> DictionaryService
}

extension DependencyContainer {
    static func createDictionaryService() -> DictionaryService {
        return DictionaryServiceImp(backendService: createBackendService())
    }
}

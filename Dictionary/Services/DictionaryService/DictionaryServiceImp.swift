//
//  DictionaryServiceImp.swift
//  Dictionary
//
//  Created by Bakhirev on 08.06.2020.
//  Copyright © 2020 Bakhirev. All rights reserved.
//

import Foundation

class DictionaryServiceImp: DictionaryService {
    let backendService: BackendService

    init(backendService: BackendService) {
        self.backendService = backendService
    }
    
    func search(
        page: Int,
        searchText: String,
        completion: @escaping (Result<[Word], Error>) -> Void
    ) {
        backendService.request(endpoint: .search(page: page, searchText: searchText), for: [Word].self, completion: { result in
            completion(result)
        })
    }

}

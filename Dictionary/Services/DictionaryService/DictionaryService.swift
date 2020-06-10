//
//  DictionaryService.swift
//  Dictionary
//
//  Created by Bakhirev on 08.06.2020.
//  Copyright © 2020 Bakhirev. All rights reserved.
//

import Foundation

protocol DictionaryService {
    func search(
        page: Int,
        searchText: String,
        completion: @escaping (Result<[Word], Error>) -> Void
    )
}

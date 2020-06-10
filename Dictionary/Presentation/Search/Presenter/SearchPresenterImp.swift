//
//  SearchPresenterImp.swift
//  Dictionary
//
//  Created by Bakhirev on 08.06.2020.
//  Copyright © 2020 Bakhirev. All rights reserved.
//

import Foundation

class SearchPresenterImp: SearchPresenter {
    private weak var view: SearchView?
    private let dictionaryService: DictionaryService
    
    init(view: SearchView, dictionaryService: DictionaryService) {
        self.view = view
        self.dictionaryService = dictionaryService
    }
    
    func fetchWords(page: Int, searchText: String) {
        dictionaryService.search(page: page, searchText: searchText, completion: { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let words):
                    self?.view?.set(words: words)
                case .failure(let error):
                    print(error)
                }
            }
        })
    }
    
}

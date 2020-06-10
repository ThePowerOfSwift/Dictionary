//
//  SearchFactory.swift
//  Dictionary
//
//  Created by Bakhirev on 08.06.2020.
//  Copyright © 2020 Bakhirev. All rights reserved.
//

import Foundation

protocol SearchFactory {
    static func createSearchModule() -> SearchView
}

extension DependencyContainer {
    static func createSearchModule() -> SearchView {
        let view = SearchViewController.nib()
        let presenter = SearchPresenterImp(view: view, dictionaryService: createDictionaryService())
        view.presenter = presenter
        return view
    }
    
}

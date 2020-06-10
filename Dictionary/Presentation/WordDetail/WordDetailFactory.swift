//
//  WordDetailFactory.swift
//  Dictionary
//
//  Created by Bakhirev on 08.06.2020.
//  Copyright © 2020 Bakhirev. All rights reserved.
//

import Foundation

protocol WordDetailFactory {
    static func createWordDetailModule(word: Word) -> WordDetailView
}

extension DependencyContainer: WordDetailFactory {
    static func createWordDetailModule(word: Word) -> WordDetailView {
        let view = WordDetailViewController.nib()
        let presenter = WordDetailPresenterImp(view: view, word: word)
        view.presenter = presenter
        return view
    }
    
}

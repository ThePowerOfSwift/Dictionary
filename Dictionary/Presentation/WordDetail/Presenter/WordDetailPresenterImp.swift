//
//  WordDetailPresenterImp.swift
//  Dictionary
//
//  Created by Bakhirev on 08.06.2020.
//  Copyright © 2020 Bakhirev. All rights reserved.
//

import Foundation

class WordDetailPresenterImp: WordDetailPresenter {
    private weak var view: WordDetailView?
    private var word: Word
    
    init(view: WordDetailView, word: Word) {
        self.view = view
        self.word = word
    }
    
    func viewLoaded() {
        var word = self.word
        word.meanings = self.word.meanings.filter({ !$0.translation.text.isEmpty })
        self.view?.set(word: word)
    }
    
}

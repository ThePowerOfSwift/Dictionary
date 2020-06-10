//
//  DictionaryTests.swift
//  DictionaryTests
//
//  Created by Bakhirev on 09.06.2020.
//  Copyright © 2020 Bakhirev. All rights reserved.
//

import XCTest
@testable import Dictionary

class WordDetailViewMock: WordDetailView {
    var word: Word?
    func set(word: Word) {
        self.word = word
    }
}

class SearchPresenterTests: XCTestCase {
    let view = WordDetailViewMock()
    var presenter: WordDetailPresenter?

    override func setUpWithError() throws {
        let emptyTranslation = Translation(text: "", note: nil)
        let translation = Translation(text: "translation", note: "note")
        let meanings = [
            Meaning(translation: emptyTranslation, previewUrl: "", imageUrl: "", transcription: ""),
            Meaning(translation: translation, previewUrl: "", imageUrl: "", transcription: "")
        ]
        
        let word = Word(id: 0, text: "", meanings: meanings)
        presenter = WordDetailPresenterImp(view: view, word: word)
        presenter?.viewLoaded()
    }

    override func tearDownWithError() throws {
    }
    
    func testWordSetting() {
        XCTAssertNotNil(view.word, "did not set word")
    }
    
    func testMeaningsFiltering() {
        XCTAssertTrue(view.word?.meanings.count == 1, "meanings did not filter")
        
        let meaning = view.word?.meanings.first
        XCTAssertNotNil(meaning, "empty meanings")
        XCTAssertTrue(!meaning!.translation.text.isEmpty, "view has meaning with empty translation")
    }
    
}

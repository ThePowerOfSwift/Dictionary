//
//  Word.swift
//  Dictionary
//
//  Created by Bakhirev on 08.06.2020.
//  Copyright © 2020 Bakhirev. All rights reserved.
//

import Foundation

struct Word: Codable {
    let id: Int
    let text: String
    var meanings: [Meaning]
}

struct Meaning: Codable {
    let translation: Translation
    let previewUrl: String?
    let imageUrl: String?
    let transcription: String
}

struct Translation: Codable {
    let text: String
    let note: String?
}

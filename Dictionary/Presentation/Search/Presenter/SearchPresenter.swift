//
//  SearchPresenter.swift
//  Dictionary
//
//  Created by Bakhirev on 08.06.2020.
//  Copyright © 2020 Bakhirev. All rights reserved.
//

import Foundation

protocol SearchPresenter {
    func fetchWords(page: Int, searchText: String)
}

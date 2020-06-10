//
//  MeaningCell.swift
//  Dictionary
//
//  Created by Bakhirev on 09.06.2020.
//  Copyright © 2020 Bakhirev. All rights reserved.
//

import UIKit

class MeaningCell: UITableViewCell {
    static let id = "MeaningCell"
    
    @IBOutlet weak var meaningLabel: UILabel!
    func setup(meaning: Meaning) {
        layer.cornerRadius = 10
        
        var text = meaning.translation.text
        if let note = meaning.translation.note,
            !note.isEmpty {
            text = text + "(" + note + ")"
        }
        
        meaningLabel.text = text
    }
    
}

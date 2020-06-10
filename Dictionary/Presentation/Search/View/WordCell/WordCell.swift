//
//  WordCell.swift
//  Dictionary
//
//  Created by Bakhirev on 08.06.2020.
//  Copyright © 2020 Bakhirev. All rights reserved.
//

import UIKit
import SDWebImage

class WordCell: UICollectionViewCell {
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    static let id = "WordCell"
    
    func setup(word: Word) {
        layer.cornerRadius = 5
        layer.masksToBounds = true
        
        wordLabel.text = word.text
        
        if let previewUrlString = word.meanings[0].previewUrl,
            let url = Endpoint.url(for: previewUrlString) {
            imageView.sd_setImage(with: url)
        }
    }
    
}

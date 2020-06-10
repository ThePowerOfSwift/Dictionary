//
//  WordDetailViewController.swift
//  Dictionary
//
//  Created by Bakhirev on 08.06.2020.
//  Copyright © 2020 Bakhirev. All rights reserved.
//

import UIKit

class WordDetailViewController: UIViewController {
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var translationLabel: UILabel!
    @IBOutlet weak var transcriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: WordDetailPresenter!
    private var meanings: [Meaning] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        presenter.viewLoaded()
    }
    
    private func setup() {
        translationLabel.text = nil
        transcriptionLabel.text = nil
        textLabel.text = nil
        
        tableView.register(MeaningCell.getNib(), forCellReuseIdentifier: MeaningCell.id)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func update(for meaning: Meaning) {
        translationLabel.text = meaning.translation.text
        transcriptionLabel.text = meaning.transcription
        
        if let imageUrlString = meaning.imageUrl,
            let url = Endpoint.url(for: imageUrlString) {
            imageView.sd_setImage(with: url)
        }
    }

}

extension WordDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meanings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MeaningCell.id, for: indexPath) as! MeaningCell
        cell.setup(meaning: meanings[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        update(for: meanings[indexPath.row])
    }
    
}

extension WordDetailViewController: WordDetailView {
    func set(word: Word) {
        textLabel.text = word.text
        
        if let meaning = word.meanings.first {
            update(for: meaning)
        }
        
        if word.meanings.count > 1 {
            meanings = word.meanings
            tableView.reloadData()
        }
    }
    
}

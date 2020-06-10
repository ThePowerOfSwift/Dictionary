//
//  SearchViewController.swift
//  Dictionary
//
//  Created by Bakhirev on 08.06.2020.
//  Copyright © 2020 Bakhirev. All rights reserved.
//

import UIKit

class SearchViewController: PaginationViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var words: [Word] = []
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchText = "type word above"
    private let throttler = Throttler(minimumDelay: 0.5)
    
    var presenter: SearchPresenter!
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        loadData()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        flowLayout.invalidateLayout()
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupKeyboardObservers()
        setupSearchController()
        
        collectionView.register(WordCell.getNib(), forCellWithReuseIdentifier: WordCell.id)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupSearchController() {
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    private func loadData() {
        showLoadingUI()
        isLoading = true
        presenter.fetchWords(page: currentPage, searchText: searchText)
    }
    
    private func showWordDetail(for word: Word) {
        if let detailModule = DependencyContainer.createWordDetailModule(word: word) as? UIViewController {
            self.navigationController?.pushViewController(detailModule, animated: true)
        }
    }
    
    // MARK: - Pagination
    
    override func loadPage() {
        super.loadPage()
        loadData()
    }
    
    override func resetPagination() {
        super.resetPagination()
        words = []
    }

}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let guide = view.safeAreaLayoutGuide
        let availableWidth = guide.layoutFrame.size.width
        let cellSize = availableWidth / 2 - 8
        return CGSize(width: cellSize, height: cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return words.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WordCell.id, for: indexPath) as! WordCell
        
        let word = words[indexPath.row]
        cell.setup(word: word)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let word = words[indexPath.row]
        self.showWordDetail(for: word)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        super.scrollViewDidScroll(scrollView)
        searchController.searchBar.endEditing(true)
    }
    
}


extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let newSearchText = searchController.searchBar.text ?? ""

        if newSearchText.isEmpty {
            searchText = ""
            resetPagination()
            collectionView.reloadData()
            return
        }
        
        guard newSearchText !=  searchText else { return }
        searchText = newSearchText
        
        throttler.throttle { [weak self] in
            guard let self = self,
                !self.searchText.isEmpty else { return }
            self.resetPagination()
            self.loadData()
        }
    }
    
}

extension SearchViewController: SearchView {
    func set(words: [Word]) {
        guard !searchText.isEmpty else { return }
        
        hideLoadingUI()
        isLoading = false
        
        self.words += words
        collectionView.reloadData()
    }
}

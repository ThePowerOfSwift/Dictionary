//
//  PaginationViewController.swift
//  Dictionary
//
//  Created by Bakhirev on 08.06.2020.
//  Copyright © 2020 Bakhirev. All rights reserved.
//

import UIKit

class PaginationViewController: BaseViewController {
    var isLoading = false
    var currentPage = 1
    
    func loadPage() {
        currentPage += 1
    }
    
    func resetPagination() {
        currentPage = 1
        isLoading = false
    }
    
}

extension PaginationViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !self.isLoading else { return }
        
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        let deltaOffset = maximumOffset - currentOffset
        
        let bottomOffsetToLoad: CGFloat = 200
        let needLoad = deltaOffset < bottomOffsetToLoad && deltaOffset > 0
        if needLoad {
            self.loadPage()
        }
    }
}

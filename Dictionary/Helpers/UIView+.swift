//
//  UIView+.swift
//  Dictionary
//
//  Created by Bakhirev on 08.06.2020.
//  Copyright © 2020 Bakhirev. All rights reserved.
//

import UIKit

extension UIView {
    private class func with<T: UIView>(nibName: String, owner: Any? = nil) -> T {
        return UINib(nibName: nibName, bundle: nil)
            .instantiate(withOwner: owner, options: nil)
            .first as! T
    }
    
    class func nib(_ nibName: String? = nil, owner: Any? = nil) -> Self {
        let nibName = nibName ?? String(describing: self)
        return with(nibName: nibName, owner: owner)
    }
    
    class func getNib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
}

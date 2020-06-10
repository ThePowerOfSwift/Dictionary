//
//  UIViewController+.swift
//  Dictionary
//
//  Created by Bakhirev on 08.06.2020.
//  Copyright © 2020 Bakhirev. All rights reserved.
//

import UIKit

extension UIViewController {
    private class func with<T: UIViewController>(nibName: String) -> T {
        return T(nibName: nibName, bundle: nil)
    }
    
    class func nib(_ nibName: String? = nil) -> Self {
        let nibName = nibName ?? String(describing: self)
        return with(nibName: nibName)
    }
    
}

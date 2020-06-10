//
//  BaseViewController.swift
//  Dictionary
//
//  Created by Bakhirev on 09.06.2020.
//  Copyright © 2020 Bakhirev. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    private let loadingIndicator = UIActivityIndicatorView()
    
    func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { (notification) in
            let keyboardRect = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
            let height = keyboardRect?.height ?? 0
            self.set(bottomConstraint: height, animationDuration: self.animationDuration(for: notification))
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { (notification) in
            self.set(bottomConstraint: 0, animationDuration: self.animationDuration(for: notification))
        }
    }
    
    private func animationDuration(for notification: Notification) -> Double {
        return notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0.5
    }
    
    private func set(bottomConstraint: CGFloat, animationDuration: Double) {
        self.bottomConstraint.constant = bottomConstraint
        UIView.animate(withDuration: animationDuration, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func showLoadingUI() {
        view.addSubview(loadingIndicator)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loadingIndicator.startAnimating()
    }
    
    func hideLoadingUI() {
        loadingIndicator.stopAnimating()
        loadingIndicator.removeFromSuperview()
    }
    
}

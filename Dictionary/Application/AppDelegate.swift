//
//  AppDelegate.swift
//  Dictionary
//
//  Created by Bakhirev on 08.06.2020.
//  Copyright © 2020 Bakhirev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupInitialUI()
        return true
    }
    
    private func setupInitialUI() {
        window = UIWindow(frame: UIScreen.main.bounds)
        if let searchModule = DependencyContainer.createSearchModule() as? UIViewController {
            window?.rootViewController = UINavigationController(rootViewController: searchModule)
        }
        window?.makeKeyAndVisible()
    }
}


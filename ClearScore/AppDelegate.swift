//
//  AppDelegate.swift
//  ClearScore
//
//  Created by Shubham Choudhary on 22/06/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: CoreCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow()
        coordinator = CoreCoordinator(window)
        
        return true
    }
}


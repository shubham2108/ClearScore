//
//  CoreCoordinator.swift
//  ClearScore
//
//  Created by Shubham Choudhary on 23/06/2022.
//

import UIKit

final class CoreCoordinator {
    
    lazy var navigationViewController: UINavigationController = {
        UINavigationController()
    }()
    
    var initialController: DashboardViewController {
        let viewController: DashboardViewController = Storyboard.ClearScore.main.instantiateViewController()
        viewController.viewModel = DashboardViewModel()
        return viewController
    }
    
    init(_ window: UIWindow?) {
        navigationViewController.viewControllers = [initialController]
        window?.rootViewController = navigationViewController
        window?.makeKeyAndVisible()
    }
}

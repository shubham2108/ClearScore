//
//  Storyboard.swift
//  ClearScore
//
//  Created by Shubham Choudhary on 22/06/2022.
//

import UIKit

extension UIStoryboard {
    
    /// Instantiates and returns the view controller of the expected type with the identifier derived from the type.
    public func instantiateViewController<T: UIViewController>(
        withIdentifier identifier: String = String(describing: T.self),
        as type: T.Type = T.self) -> T
    {
        guard let viewController = instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("Found mismatched view controller type with identifier '\(identifier)'")
        }
        return viewController
    }
}


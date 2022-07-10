//
//  StoryboardName.swift
//  ClearScore
//
//  Created by Shubham Choudhary on 22/06/2022.
//

import UIKit

public protocol StoryboardName {
    var name: String { get }
    var bundle: Bundle? { get }
    func instantiateViewController<T: UIViewController>(as type: T.Type) -> T
}

extension StoryboardName {
    
    private var storyboard: UIStoryboard {
        return UIStoryboard(name: name, bundle: bundle)
    }
    
    public func instantiateViewController<T: UIViewController>(as type: T.Type = T.self) -> T {
        return storyboard.instantiateViewController(as: type)
    }
}

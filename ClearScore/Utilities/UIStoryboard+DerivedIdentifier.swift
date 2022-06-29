//
//  UIStoryboard+DerivedIdentifier.swift
//  ClearScore
//
//  Created by Shubham Choudhary on 22/06/2022.
//

import Foundation

struct Storyboard {
    fileprivate class Bundle {}
}

extension Storyboard {
    enum ClearScore: String, StoryboardName {
        case main

        var name: String {
            return rawValue.capitalized
        }
    }
}

extension StoryboardName {

    var bundle: Bundle? {
        return Bundle(for: Storyboard.Bundle.self)
    }
}

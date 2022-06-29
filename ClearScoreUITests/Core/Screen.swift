//
//  Screen.swift
//  ClearScoreUITests
//
//  Created by Shubham Choudhary on 27/06/2022.
//

import XCTest

protocol Screen {
    var identifier: String { get }
}

extension Screen {

    @discardableResult
    func waitToAppear(timeout: TimeInterval = 10, file: StaticString = #file, line: UInt = #line) -> Self {
        let screen = XCUIApplication().otherElements[identifier]
        if !screen.waitForExistence(timeout: timeout) {
            XCTFail("Timed out waiting for screen: \(identifier)", file: file, line: line)
        }
        return self
    }
    
    func assertTitle(_ title: String) {
        let predicateEvaluation = NSPredicate(format: #"label == "\#(title)""#)
        XCTAssertTrue(XCUIApplication().staticTexts.containing(predicateEvaluation).element.exists)
    }
}

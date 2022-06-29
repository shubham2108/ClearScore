//
//  XCUIElement+Additions.swift
//  ClearScoreUITests
//
//  Created by Shubham Choudhary on 27/06/2022.
//

import XCTest

extension XCUIElement {
    
    func waitForElement(timeout: TimeInterval = 10, file: StaticString = #file, line: UInt = #line) {
        XCTAssertTrue(waitForExistence(timeout: timeout), file: file, line: line)
    }
    
    @discardableResult
    func waitUntilExists(_ exists: Bool, timeout: TimeInterval = 10, file: StaticString = #file, line: UInt = #line) -> Self {
        waitUntil(predicateFormat: "exists == \(exists ? "true" : "false")", timeout: timeout, file: file, line: line)
        return self
    }
    
    @discardableResult
    func tapWhenHittable(timeout: TimeInterval = 10, file: StaticString = #file, line: UInt = #line) -> Self {
        waitUntil(isHittable: true, timeout: timeout, file: file, line: line).tap()
        return self
    }
    
    @discardableResult
    func waitUntil(isHittable: Bool, timeout: TimeInterval = 10, file: StaticString = #file, line: UInt = #line) -> Self {
        waitUntil(predicateFormat: "isHittable == \(isHittable ? "true" : "false")", timeout: timeout, file: file, line: line)
        return self
    }
    
    private func waitUntil(predicateFormat: String, timeout: TimeInterval, file: StaticString, line: UInt) {
        let predicateEvaluation = NSPredicate(format: "\(predicateFormat)")
        let expectation = XCTNSPredicateExpectation(predicate: predicateEvaluation, object: self)
        let evaluationResult = XCTWaiter.wait(for: [expectation], timeout: timeout)
        XCTAssertEqual(evaluationResult, .completed, file: file, line: line)
    }
    
    func waitForText(
        text: String,
        source: AccessibilitySource = .label,
        isUppercased: Bool = false,
        timeout: TimeInterval = 10,
        file: StaticString = #file,
        line: UInt = #line)
    {
        var expectedText = text
        if isUppercased {
            expectedText = text.uppercased()
        }
        
        let predicateEvaluation = NSPredicate(format: "%K == %@", source.rawValue, expectedText)
        let expectation = XCTNSPredicateExpectation(predicate: predicateEvaluation, object: self)
        let evaluationResult = XCTWaiter.wait(for: [expectation], timeout: timeout)
        
        XCTAssertEqual(evaluationResult, .completed, "The expected text: \(expectedText) did not appear", file: file, line: line)
    }
    
    enum AccessibilitySource: String {
        case label
    }
}

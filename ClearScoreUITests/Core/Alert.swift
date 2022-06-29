//
//  Alert.swift
//  ClearScoreUITests
//
//  Created by Shubham Choudhary on 27/06/2022.
//

import XCTest

protocol Alert {
    var view: XCUIElement { get }
}

extension Alert {
    
    @discardableResult
    func waitToAppear(timeout: TimeInterval = 10, file: StaticString = #file, line: UInt = #line) -> Self {
        let predicateEvaluation = NSPredicate(format: "isHittable == true")
        let expectation = XCTNSPredicateExpectation(predicate: predicateEvaluation, object: view)
        let evaluationResult = XCTWaiter.wait(for: [expectation], timeout: timeout)
        XCTAssertEqual(evaluationResult, .completed, "'\(type(of: self))' did not appear", file: file, line: line)
        return self
    }
    
    @discardableResult
    func waitToDisappear(timeout: TimeInterval = 10, file: StaticString = #file, line: UInt = #line) -> Self {
        let predicateEvaluation = NSPredicate(format: "exists == false")
        let expectation = XCTNSPredicateExpectation(predicate: predicateEvaluation, object: view)
        let evaluationResult = XCTWaiter.wait(for: [expectation], timeout: timeout)
        XCTAssertEqual(evaluationResult, .completed, "'\(type(of: self))' was not dismissed", file: file, line: line)
        return self
    }
}

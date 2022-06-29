//
//  NetworkErrorAlert.swift
//  ClearScoreUITests
//
//  Created by Shubham Choudhary on 27/06/2022.
//

import XCTest

final class NetworkErrorAlert: Alert {
    
    let view: XCUIElement
    
    private let titleLabel: XCUIElement
    private let description: XCUIElement
    private let retryButton: XCUIElement
    private let cancelButton: XCUIElement

    init(repeatedEvent: Bool = false, application: XCUIApplication = XCUIApplication()) {
        view = application.alerts.element
        titleLabel = view.staticTexts["Alert"]
        description = view.staticTexts["We failed to get your credit score. Please retry."]
        retryButton = view.buttons["Retry"]
        cancelButton = view.buttons["Cancel"]
    }
    
    // MARK: - Assertions
    
    @discardableResult
    func assertStaticText() -> Self {
        description.waitUntilExists(true)
        titleLabel.waitUntilExists(true)
        return self
    }
    
    // MARK: - Interactions
    
    @discardableResult
    func tapRetry() -> Self {
        retryButton.tapWhenHittable()
        return self
    }
    
    @discardableResult
    func tapCancel() -> Self {
        cancelButton.tapWhenHittable()
        return self
    }
}


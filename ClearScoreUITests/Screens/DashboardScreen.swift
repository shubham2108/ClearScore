//
//  DashboardScreen.swift
//  ClearScoreUITests
//
//  Created by Shubham Choudhary on 27/06/2022.
//

import XCTest

final class DashboardScreen: Screen {

    let identifier: String = "dashboard_screen"
    
    private let creditScoreTitleLabel: XCUIElement
    private let creditScoreLabel: XCUIElement
    private let maxCreditScoreLabel: XCUIElement
    
    init(application: XCUIApplication = XCUIApplication()) {
        let screen = application.otherElements[identifier]
        creditScoreTitleLabel = application.staticTexts["score_title_label"]
        creditScoreLabel = screen.staticTexts["score_label"]
        maxCreditScoreLabel = screen.staticTexts["max_score_label"]
    }
    
    // MARK: - Assertions
    
    @discardableResult
    func assertStaticElements() -> Self {
        assertTitle("Dashboard")
        creditScoreTitleLabel.waitForText(text: "Your credit score is")
        return self
    }
    
    @discardableResult
    func assertCreditScore(_ score: String) -> Self {
        creditScoreLabel.waitForText(text: score)
        return self
    }
    
    @discardableResult
    func assertMaxCreditScore(_ score: String) -> Self {
        maxCreditScoreLabel.waitForText(text: "out of " + score)
        return self
    }
    
    // MARK: - Interactions
    
    @discardableResult
    func tapCloseButton() -> Self {
//        closeButton.tapWhenEnabled()
        return self
    }
}


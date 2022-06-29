//
//  UITestCase.swift
//  ClearScoreUITests
//
//  Created by Shubham Choudhary on 26/06/2022.
//

import XCTest

class UITestCase: XCTestCase {
    
    enum ResponseType: String {
        case error = "errorResponse"
        case success = "successResponse"
    }

    let application = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false

        application.launchArguments += ["XCUI"]
    }

    override func tearDownWithError() throws {
        application.terminate()

        try super.tearDownWithError()
    }
}

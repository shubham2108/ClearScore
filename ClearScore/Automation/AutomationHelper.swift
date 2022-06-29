//
//  AutomationHelper.swift
//  ClearScore
//
//  Created by Shubham Choudhary on 28/06/2022.
//

import Foundation

// It's a helper to access the information from the launch arguments for automation testing
struct AutomationHelper {
    enum Keys {
        static let automationTesting = "XCUI"
        static let successResponse = "successResponse"
        static let errorResponse = "errorResponse"
    }
    
    // Use it to check, if automation tests are running or not
    var isEnabled: Bool {
        ProcessInfo.processInfo.arguments.contains(Keys.automationTesting)
    }
    
    // To get mock response for automation tests
    func getMockedResponse() -> Data {
        if ProcessInfo.processInfo.arguments.contains(Keys.successResponse) {
            return Mock.successResponse
        }
        
        if ProcessInfo.processInfo.arguments.contains(Keys.successResponse) {
            return Mock.errorResponse
        }
        
        return Data()
    }
}


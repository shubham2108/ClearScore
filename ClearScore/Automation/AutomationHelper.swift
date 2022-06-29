//
//  AutomationHelper.swift
//  ClearScore
//
//  Created by Shubham Choudhary on 28/06/2022.
//

import Foundation

struct AutomationHelper {
    enum Keys {
        static let automationTesting = "XCUI"
        static let successResponse = "successResponse"
        static let errorResponse = "errorResponse"
    }
    
    var isEnabled: Bool {
        ProcessInfo.processInfo.arguments.contains(Keys.automationTesting)
    }
    
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


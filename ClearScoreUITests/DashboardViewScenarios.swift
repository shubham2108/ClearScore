//
//  DashboardViewScenarios.swift
//  ClearScoreUITests
//
//  Created by Shubham Choudhary on 26/06/2022.
//

final class DashboardViewScenarios: UITestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        
        try super.setUpWithError()
    }
    
    func testDeshboardViewContent_whenNetworkRequestNotFailed() {
        application.launchArguments += [ResponseType.success.rawValue]
        application.launch()
        
        DashboardScreen()
            .waitToAppear()
            .assertStaticElements()
            .assertCreditScore("300")
            .assertMaxCreditScore("1000")
    }
    
    func testDeshboardViewContent_whenNetworkRequestFailed() {
        application.launchArguments += [ResponseType.error.rawValue]
        application.launch()
        
        DashboardScreen()
            .waitToAppear()
            .assertStaticElements()
        
        NetworkErrorAlert()
            .assertStaticText()
            .tapRetry()
            .tapCancel()
            .waitToDisappear()
    }
}

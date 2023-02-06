//
//  DashboardViewScenarios.swift
//  ClearScoreUITests
//
//  Created by Shubham Choudhary on 26/06/2022.
//

import XCTest
import Shock

final class DashboardViewScenarios: UITestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        
        try super.setUpWithError()
    }
    
    func testDeshboardViewContent_whenNetworkRequestNotFailed_usingWireMock() {
		postData(score: 800)

        application.launchArguments += [ResponseType.success.rawValue]
        application.launch()

		DashboardScreen()
			.waitToAppear()
			.assertStaticElements()
			.assertCreditScore("800")
			.assertMaxCreditScore("2000")
    }

	func testDeshboardViewContent_whenNetworkRequestNotFailed_usingShock() {
		let route: MockHTTPRoute = .simple(
			method: .get,
			urlPath: "/mockcredit/values",
			code: 200,
			filename: "CreditScore.json"
		)

		mockServer.setup(route: route)

		application.launchArguments += [ResponseType.success.rawValue]
		application.launch()

		DashboardScreen()
			.waitToAppear()
			.assertStaticElements()
			.assertCreditScore("600")
			.assertMaxCreditScore("1500")
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

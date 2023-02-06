//
//  UITestCase.swift
//  ClearScoreUITests
//
//  Created by Shubham Choudhary on 26/06/2022.
//

import XCTest
import Shock

class UITestCase: XCTestCase {
    
    enum ResponseType: String {
        case error = "errorResponse"
        case success = "successResponse"
    }

    let application = XCUIApplication()
	var mockServer: MockServer!
    
    override func setUpWithError() throws {
        continueAfterFailure = false

		//Shock
		mockServer = MockServer(port: 9999, bundle: Bundle(for: BundleFinder.self))
		mockServer.start()
		//

        // Set "XCUI" launch argument for all the tests
        application.launchArguments += ["-runLocal"]
    }

    override func tearDownWithError() throws {
        application.terminate()
		//Shock
		mockServer.stop()
		//
		//WireMock
		resetRequest()

        try super.tearDownWithError()
    }

	func postData(score: Int) {
		let json: [String: Any] = [
			"id": "8c5db8b0-2db4-4ad7-a99f-38c9b00da3f7",
			"request": [
				"url": "/mockcredit/values",
				"method": "GET"
			],
			"response": [
				"status": 200,
				"body": """
					{
					"creditReportInfo": {
						"score": \(score),
						"scoreBand": 3,
						"maxScoreValue": 2000,
						"minScoreValue": 0
					},
					"dashboardStatus": "FAIL",
					"personaType": "INEXPERIENCED"
					}
				"""
			]
		]

		let jsonData = try? JSONSerialization.data(withJSONObject: json)
		guard let url = URL(string: "http://localhost:9999/__admin/mappings/new") else {return}

		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		request.httpBody = jsonData

//		request.setValue("text/plain", forHTTPHeaderField: "Content-Type")
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")

		let task = URLSession.shared.dataTask(with: request) { (data, response, error) in }
		task.resume()
	}

	func editData(score: String, id: String = "8c5db8b0-2db4-4ad7-a99f-38c9b00da3f7") {
		let json: [String: Any] = [
			"request": [
				"url": "/mockcredit/values",
				"method": "GET"
			],
			"response": [
				"status": 200,
				"body": """
					{
					"creditReportInfo": {
						"score": \(score),
						"scoreBand": 3,
						"maxScoreValue": 2000,
						"minScoreValue": 0
					},
					"dashboardStatus": "FAIL",
					"personaType": "INEXPERIENCED"
					}
				"""
			]
		]

		let jsonData = try? JSONSerialization.data(withJSONObject: json)

		guard let url = URL(string: "http://localhost:9999/__admin/mappings/\(id)") else {return}

		var request = URLRequest(url: url)
		request.httpMethod = "PUT"
		request.httpBody = jsonData

		request.setValue("text/plain", forHTTPHeaderField: "Content-Type")

		let task = URLSession.shared.dataTask(with: request) { (data, response, error) in }
		task.resume()
	}

	func saveRequest() {
		let url = URL(string: "http://localhost:9999/__admin/mappings/save")!
		var request = URLRequest(url: url)
		request.httpMethod = "POST"

		let task = URLSession.shared.dataTask(with: request) { data, response, error in }
		task.resume()
	}

	func resetRequest() {
		let url = URL(string: "http://localhost:9999/__admin/reset")!
		var request = URLRequest(url: url)
		request.httpMethod = "POST"

		let task = URLSession.shared.dataTask(with: request) { data, response, error in }
		task.resume()
	}
}

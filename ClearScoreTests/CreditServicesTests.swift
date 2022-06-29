//
//  CreditServicesTests.swift
//  ClearScoreTests
//
//  Created by Shubham Choudhary on 26/06/2022.
//

import XCTest
import Combine

@testable import ClearScore

final class CreditServicesTests: XCTestCase {

    private var creditServices: CreditServices!
    private var disposables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        creditServices = CreditServices(session: MockURLSessoin.session)
    }
    
    override func tearDownWithError() throws {
        MockURLProtocol.requestHandler = nil
        MockURLProtocol.error = nil
        
        try super.tearDownWithError()
    }
    
    func testCreditDetailsRequestSucceeds_whenValidResponse() throws {
        let expectationReceived = expectation(description: "Response received")
        let expectationFinished = expectation(description: "Finished")
        
        let publisher = creditServices.creditDetails()
        MockURLProtocol.requestHandler = { request in
            (Mock.validResponse, Mock.creditDetailsData)
        }
        
        assertResponse(
            publisher: publisher,
            expectationReceived: expectationReceived,
            expectationFinished: expectationFinished)
        
        wait(for: [expectationReceived, expectationFinished], timeout: 1)
    }
    
    func testCreditDetailsRequestFails_whenInvalidResponse() throws {
        let expectationFailure = expectation(description: #function)
        
        let publisher = creditServices.creditDetails()
        MockURLProtocol.requestHandler = { request in
            (Mock.invalidResponse, nil)
        }
        
        assertResponse(publisher: publisher, expectationFailure: expectationFailure)
        
        waitForExpectations(timeout: 1)
    }
    
    func testCreditDetailsRequestFails_whenInvalidDataAndValidResponse() throws {
        let expectationFailure = expectation(description: #function)
        
        let publisher = creditServices.creditDetails()
        MockURLProtocol.requestHandler = { request in
            (Mock.validResponse, Data("{{}".utf8))
        }
        
        assertResponse(publisher: publisher, expectationFailure: expectationFailure)
        
        waitForExpectations(timeout: 1)
    }
    
    func testCreditDetailsRequestFails_whenNetworkError() throws {
        let expectationFailure = expectation(description: #function)
        
        let publisher = creditServices.creditDetails()
        MockURLProtocol.requestHandler = { request in
            (Mock.validResponse, nil)
        }
        MockURLProtocol.error = Mock.networkError
        
        assertResponse(publisher: publisher, expectationFailure: expectationFailure)
        
        waitForExpectations(timeout: 1)
    }

}

private extension CreditServicesTests {
    
    func assertResponse<T: Publisher>(
        publisher: T,
        expectationReceived: XCTestExpectation? = nil,
        expectationFinished: XCTestExpectation? = nil,
        expectationFailure: XCTestExpectation? = nil)
    {
        publisher
            .sink { completion in
            switch completion {
            case .failure:
                expectationFailure?.fulfill()
            case .finished:
                expectationFinished?.fulfill()
            }
        } receiveValue: { response in
            XCTAssertNotNil(response)
            expectationReceived?.fulfill()
        }
        .store(in: &disposables)
    }
}

private extension CreditServicesTests {
    struct Mock {
        static let creditDetailsData = Data("""
        {
            "creditReportInfo": {
                "score": 300,
                "scoreBand": 4,
                "maxScoreValue": 1000,
                "minScoreValue": 0
            },
            "dashboardStatus": "PASS",
            "personaType": "INEXPERIENCED"
        }
        """.utf8)
        
        static let invalidResponse = URLResponse(
            url: URL(string: "http://localhost:8080")!,
            mimeType: nil,
            expectedContentLength: 0,
            textEncodingName: nil)
        
        static let validResponse = HTTPURLResponse(
            url: URL(string: "http://localhost:8080")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil)!
        
        static let networkError = NSError(
            domain: "NSURLErrorDomain",
            code: -1004,
            userInfo: nil)
    }
}

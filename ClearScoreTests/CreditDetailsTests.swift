//
//  CreditDetailsTests.swift
//  ClearScoreTests
//
//  Created by Shubham Choudhary on 26/06/2022.
//

import XCTest

@testable import ClearScore

final class CreditDetailsTests: XCTestCase {
    
    private let decoder = JSONDecoder()
    
    func testCreditDetailsDecodedSuccessfully_whenJSONIsCorrect() throws {
        let data = try decoder.decode(CreditDetails.self, from: MockCreditDetals.data)
        
        XCTAssertEqual(data.dashboardStatus, "PASS")
        XCTAssertEqual(data.personaType, "INEXPERIENCED")
        XCTAssertEqual(data.creditReportInfo.score, 300)
        XCTAssertEqual(data.creditReportInfo.scoreBand, 4)
        XCTAssertEqual(data.creditReportInfo.maxScoreValue, 1000)
        XCTAssertEqual(data.creditReportInfo.minScoreValue, 0)
    }
    
    func testCreditDetailsDecodedThrowsError_whenCreditReportInfoIsMissing() throws {
        let data = Data("""
        {
            "dashboardStatus": "PASS",
            "personaType": "INEXPERIENCED"
        }
        """.utf8)
        
        XCTAssertThrowsError(try decoder.decode(CreditDetails.self, from: data))
    }
    
    func testCreditDetailsDecodedThrowsError_whenScoreIsMissing() throws {
        let data = Data("""
        {
            "creditReportInfo": {
                "scoreBand": 4,
                "maxScoreValue": 1000,
                "minScoreValue": 0
            },
            "dashboardStatus": "PASS",
            "personaType": "INEXPERIENCED"
        }
        """.utf8)
        
        XCTAssertThrowsError(try decoder.decode(CreditDetails.self, from: data))
    }
    
    func testCreditDetailsDecodedThrowsError_whenDashboardStatusIsMissing() throws {
        let data = Data("""
        {
            "creditReportInfo": {
                "score": 300,
                "scoreBand": 4,
                "maxScoreValue": 1000,
                "minScoreValue": 0
            },
            "personaType": "INEXPERIENCED"
        }
        """.utf8)
        
        XCTAssertThrowsError(try decoder.decode(CreditDetails.self, from: data))
    }
    
    func testCreditDetailsDecodedThrowsError_whenMaxScoreValueIsMissing() throws {
        let data = Data("""
        {
            "creditReportInfo": {
                "score": 300,
                "scoreBand": 4,
                "minScoreValue": 0
            },
            "dashboardStatus": "PASS",
            "personaType": "INEXPERIENCED"
        }
        """.utf8)
        
        XCTAssertThrowsError(try decoder.decode(CreditDetails.self, from: data))
    }
    
}

extension CreditDetailsTests {
    
    struct MockCreditDetals {
        static let data = Data("""
        {
           "accountIDVStatus": "PASS",
           "creditReportInfo": {
              "score": 300,
              "scoreBand": 4,
              "clientRef": "CS-SED-655426-708782",
              "status": "MATCH",
              "maxScoreValue": 1000,
              "minScoreValue": 0,
              "changedScore": 0,
              "equifaxScoreBand": 4,
              "equifaxScoreBandDescription": "Excellent",
              "daysUntilNextReport": 9
           },
           "dashboardStatus": "PASS",
           "personaType": "INEXPERIENCED"
        }
        """.utf8)
    }
}


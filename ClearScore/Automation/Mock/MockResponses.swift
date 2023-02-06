//
//  MockResponses.swift
//  ClearScore
//
//  Created by Shubham Choudhary on 27/06/2022.
//

import Foundation

// It's mocking success and failure credit details response
struct Mock {
    static let successResponse = Data("""
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
    
    static let errorResponse = Data("{{}".utf8)
}

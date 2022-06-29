//
//  CreditDetails.swift
//  ClearScore
//
//  Created by Shubham Choudhary on 23/06/2022.
//

struct CreditDetails: Codable {
    let dashboardStatus: String
    let creditReportInfo: Report
    let personaType: String
    
    struct Report: Codable {
        let score: Int
        let scoreBand: Int
        let maxScoreValue: Int
        let minScoreValue: Int
    }
}


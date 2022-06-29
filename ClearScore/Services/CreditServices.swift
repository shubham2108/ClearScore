//
//  ScoreService.swift
//  ClearScore
//
//  Created by Shubham Choudhary on 23/06/2022.
//

import Combine
import Foundation

protocol CreditServicing {
    func creditDetails() -> AnyPublisher<CreditDetails, HTTPError>
}

final class CreditServices {
    private let baseURL: String
    private let session: URLSession
    
    init(
        session: URLSession = .shared,
        baseURL: String = "https://5lfoiyb0b3.execute-api.us-west-2.amazonaws.com/prod")
    {
        self.baseURL = baseURL
        self.session = session
    }
}

extension CreditServices: CreditServicing {
    
    func creditDetails() -> AnyPublisher<CreditDetails, HTTPError> {
        HTTPManager(session: session).fetch(with: baseURL + "/mockcredit/values")
    }
}

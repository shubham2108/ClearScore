//
//  MockCreditServices.swift
//  ClearScoreTests
//
//  Created by Shubham Choudhary on 26/06/2022.
//

import Foundation
import Combine

@testable import ClearScore

final class MockCreditServices: CreditServicing {
    private let userCreditDetails: CreditDetails?
    
    init(creditDetails: CreditDetails? = nil) {
        self.userCreditDetails = creditDetails
    }
    
    func creditDetails() -> AnyPublisher<CreditDetails, HTTPError> {
        guard let creditDetails = userCreditDetails else {
            return Fail(error: HTTPError.networkError("")).eraseToAnyPublisher()
        }
        
        return Just(creditDetails)
            .setFailureType(to: HTTPError.self)
            .eraseToAnyPublisher()
    }
}

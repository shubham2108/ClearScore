//
//  HttpManager.swift
//  ClearScore
//
//  Created by Shubham Choudhary on 22/06/2022.
//

import Foundation
import Combine

//Error enum
enum HTTPError: Error {
    case invalidURL
    case parsingError(String)
    case networkError(String)
}

final class HTTPManager {
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func fetch<T: Decodable>(with url: String) -> AnyPublisher<T, HTTPError> {
        
        // Mock response when running XCUI tests
        guard !AutomationHelper().isEnabled else {
            return mockFetch(with: url)
        }
        
        guard let dataURL = URL(string: url) else {
            return Fail(error: HTTPError.invalidURL).eraseToAnyPublisher()
        }
                
        return session
            .dataTaskPublisher(for: dataURL)
            .mapError { HTTPError.networkError($0.localizedDescription) }
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError{ HTTPError.parsingError($0.localizedDescription) }
            .eraseToAnyPublisher()
    }
}

// Mock response for UI automation tests
extension HTTPManager {
    
    func mockFetch<T: Decodable>(with url: String) -> AnyPublisher<T, HTTPError> {
        let userCreditDetails = try? JSONDecoder().decode(T.self, from: AutomationHelper().getMockedResponse())

        guard let creditDetails = userCreditDetails else {
            return Fail(error: HTTPError.networkError("")).eraseToAnyPublisher()
        }

        return Just(creditDetails)
            .setFailureType(to: HTTPError.self)
            .eraseToAnyPublisher()
    }
}

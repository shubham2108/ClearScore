//
//  NetworkManager.swift
//  ClearScore
//
//  Created by Shubham Choudhary on 10/07/2022.
//

import Foundation
import Combine

final class NetworkManager: DataProviding {
    
    private var networkRequest: DataProviding {
        // Mock response when running XCUI tests
//        guard !AutomationHelper().shouldRunLocal else {
//            return MockRequest()
//        }
        
        return HTTPRequest(session: session)
    }

	private var baseURL: String {
		let localHost = "http://localhost:9999"
		let baseURL = "https://5lfoiyb0b3.execute-api.us-west-2.amazonaws.com/prod"
		return AutomationHelper().shouldRunLocal ? localHost : baseURL
	}
    
    let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func fetch<T>(with url: String) -> AnyPublisher<T, HTTPError> where T : Decodable {
        networkRequest.fetch(with: baseURL + url)
    }
}

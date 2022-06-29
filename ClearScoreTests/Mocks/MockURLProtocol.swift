//
//  MockURLProtocol.swift
//  ClearScoreTests
//
//  Created by Shubham Choudhary on 26/06/2022.
//

import XCTest

// Mock `URLProtocol` to test the services
final class MockURLProtocol: URLProtocol {
    static var requestHandler: ((URLRequest) throws -> (URLResponse, Data?))?
    static var error: Error?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        guard let handler = MockURLProtocol.requestHandler else {
            XCTFail("Received unexpected request with no handler set")
            return
        }
        
        if let error = MockURLProtocol.error {
            client?.urlProtocol(self, didFailWithError: error)
        }
        
        do {
            let (response, data) = try handler(request)
            if let data = data {
                client?.urlProtocol(self, didLoad: data)
            }
            
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    override func stopLoading() { }
}

struct MockURLSessoin {
    static var session: URLSession {
        // Set mock url session
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: configuration)
    }
}


//
//  DashboardViewModelTests.swift
//  ClearScoreTests
//
//  Created by Shubham Choudhary on 26/06/2022.
//

import XCTest
import Combine

@testable import ClearScore

final class DashboardViewModelTests: XCTestCase {
    
    private var disposables = Set<AnyCancellable>()
    
    func testCreditScores_whenFetchSucceed() throws {
        let currentCreditExpectation = expectation(description: "Current credit score.")
        let maxCreditExpectation = expectation(description: "Maximum credit score.")
        
        let expectedCurrentCreditScore = ["", "100"]
        let expectedMaxCreditScore = ["", "out of 1000"]
        
        var receivedCurrentCreditScore: [String] = []
        var receivedMaxCreditScore: [String] = []
        
        let mockCreditServices = MockCreditServices(creditDetails: Mock.creditDetails)
        let viewModel = DashboardViewModel(service: mockCreditServices)
        
        viewModel.$currentScore.sink {
            receivedCurrentCreditScore.append($0)
            if receivedCurrentCreditScore == expectedCurrentCreditScore {
                currentCreditExpectation.fulfill()
            }
        }
        .store(in: &disposables)
        
        viewModel.$maxScore.sink {
            receivedMaxCreditScore.append($0)
            if receivedMaxCreditScore == expectedMaxCreditScore {
                maxCreditExpectation.fulfill()
            }
        }
        .store(in: &disposables)
        
        viewModel.fetchCreditScore()
        
        wait(for: [currentCreditExpectation, maxCreditExpectation], timeout: 0.1)
    }
    
    func testCreditScores_whenFetchFailed() throws {
        let currentCreditExpectation = expectation(description: "Failed to get current credit score.")
        let maxCreditExpectation = expectation(description: "Failed to get maximum credit score.")
        
        let expectedCurrentCreditScore = [""]
        let expectedMaxCreditScore = [""]
        
        var receivedCurrentCreditScore: [String] = []
        var receivedMaxCreditScore: [String] = []
        
        let mockCreditServices = MockCreditServices()
        let viewModel = DashboardViewModel(service: mockCreditServices)
        
        viewModel.$currentScore.sink {
            receivedCurrentCreditScore.append($0)
            if receivedCurrentCreditScore == expectedCurrentCreditScore {
                currentCreditExpectation.fulfill()
            }
        }
        .store(in: &disposables)
        
        viewModel.$maxScore.sink {
            receivedMaxCreditScore.append($0)
            if receivedMaxCreditScore == expectedMaxCreditScore {
                maxCreditExpectation.fulfill()
            }
        }
        .store(in: &disposables)
        
        viewModel.fetchCreditScore()
        
        wait(for: [currentCreditExpectation, maxCreditExpectation], timeout: 0.1)
    }
    
    func testErrorAlert_whenFetchSucceed() throws {
        let expectation = expectation(description: #function)
        let expectedStates = [false]
        var receivedStates: [Bool] = []
        
        let mockCreditServices = MockCreditServices(creditDetails: Mock.creditDetails)
        let viewModel = DashboardViewModel(service: mockCreditServices)
        
        viewModel.$showAlert.sink {
            receivedStates.append($0)
            if receivedStates == expectedStates {
                expectation.fulfill()
            }
        }
        .store(in: &disposables)
        
        viewModel.fetchCreditScore()
        
        waitForExpectations(timeout: 0.1)
    }
    
    func testErrorAlert_whenFetchFailed() throws {
        let expectation = expectation(description: #function)
        let expectedStates = [false, true]
        var receivedStates: [Bool] = []
        
        let mockCreditServices = MockCreditServices()
        let viewModel = DashboardViewModel(service: mockCreditServices)
        
        viewModel.$showAlert.sink {
            receivedStates.append($0)
            if receivedStates == expectedStates {
                expectation.fulfill()
            }
        }
        .store(in: &disposables)
        
        viewModel.fetchCreditScore()
        
        waitForExpectations(timeout: 0.1)
    }
    
    func testSpinnerStates_whenFetchSucceed() throws {
        let expectation = expectation(description: #function)
        let expectedStates = [false, true, false]
        var receivedStates: [Bool] = []
        
        let mockCreditServices = MockCreditServices(creditDetails: Mock.creditDetails)
        let viewModel = DashboardViewModel(service: mockCreditServices)
        
        viewModel.$showSpinner.sink {
            receivedStates.append($0)
            if receivedStates == expectedStates {
                expectation.fulfill()
            }
        }
        .store(in: &disposables)
        
        viewModel.fetchCreditScore()
        
        waitForExpectations(timeout: 0.1)
    }
    
    func testSpinnerStates_whenFetchFailed() throws {
        let expectation = expectation(description: #function)
        let expectedStates = [false, true, false]
        var receivedStates: [Bool] = []
        
        let mockCreditServices = MockCreditServices()
        let viewModel = DashboardViewModel(service: mockCreditServices)
        
        viewModel.$showSpinner.sink {
            receivedStates.append($0)
            if receivedStates == expectedStates {
                expectation.fulfill()
            }
        }
        .store(in: &disposables)
        
        viewModel.fetchCreditScore()
        
        waitForExpectations(timeout: 0.1)
    }
    
    func testProgressIndicatorValue_whenFetchSucceed() throws {
        let expectation = expectation(description: #function)
        let expectedStates: [Double] = [0, 10]
        var receivedStates: [Double] = []
        
        let mockCreditServices = MockCreditServices(creditDetails: Mock.creditDetails)
        let viewModel = DashboardViewModel(service: mockCreditServices)
        
        viewModel.$progressIndicatorValue.sink {
            receivedStates.append($0)
            if receivedStates == expectedStates {
                expectation.fulfill()
            }
        }
        .store(in: &disposables)
        
        viewModel.fetchCreditScore()
        
        waitForExpectations(timeout: 0.1)
    }
    
    func testProgressIndicatorValue_whenFetchFailed() throws {
        let expectation = expectation(description: #function)
        let expectedStates: [Double] = [0]
        var receivedStates: [Double] = []
        
        let mockCreditServices = MockCreditServices()
        let viewModel = DashboardViewModel(service: mockCreditServices)
        
        viewModel.$progressIndicatorValue.sink {
            receivedStates.append($0)
            if receivedStates == expectedStates {
                expectation.fulfill()
            }
        }
        .store(in: &disposables)
        
        viewModel.fetchCreditScore()
        
        waitForExpectations(timeout: 0.1)
    }
}

//Mock data for tests
private extension DashboardViewModelTests {
    struct Mock {
        static let creditDetails = CreditDetails(
            dashboardStatus: "PASS",
            creditReportInfo: CreditDetails.Report(
                score: 100,
                scoreBand: 8,
                maxScoreValue: 1000,
                minScoreValue: 0),
            personaType: "INEXPERIENCED")
    }
}

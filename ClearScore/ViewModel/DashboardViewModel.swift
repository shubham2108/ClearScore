//
//  DashboardViewModel.swift
//  ClearScore
//
//  Created by Shubham Choudhary on 22/06/2022.
//

import UIKit
import Foundation
import Combine

final class DashboardViewModel {
    
    private struct Constants {
        static let title = "Dashboard".localized
        static let yourCredtScoreText = "Your credit score is".localized
        static let maximumScoreText = "out of %d"
    }
    
    let viewTitle = Constants.title
    let credtScoreTitleText = Constants.yourCredtScoreText
    
    @Published private(set) var currentScore: String = ""
    @Published private(set) var maxScore: String = ""
    @Published private(set) var showAlert: Bool = false
    @Published private(set) var showSpinner: Bool = false
    @Published private(set) var progressIndicatorValue: Double = .zero
    
    private let service: CreditServicing?
    private var disposables = Set<AnyCancellable>()
    
    init(service: CreditServicing = CreditServices()) {
        self.service = service
    }
    
    // Fetch credit score from the server
    func fetchCreditScore() {
        showSpinner = true
        service?.creditDetails()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.showSpinner = false
                switch completion {
                case .finished: break
                case .failure: self?.showAlert = true
                }
            }, receiveValue: { [weak self] details in
                guard let self = self else { return }
                
                self.currentScore = "\(details.creditReportInfo.score)"
                self.maxScore = Constants.maximumScoreText.localized(with: details.creditReportInfo.maxScoreValue)
                self.progressIndicatorValue = (Double(details.creditReportInfo.score) / Double(details.creditReportInfo.maxScoreValue)) * 100
            })
            .store(in: &disposables)
    }
}

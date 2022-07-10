//
//  ViewController.swift
//  ClearScore
//
//  Created by Shubham Choudhary on 22/06/2022.
//

import UIKit
import Combine

final class DashboardViewController: UIViewController {
    
    private struct Constants {
        static let alertTitle = "Alert".localized
        static let alertBody = "We failed to get your credit score. Please retry.".localized
        static let alertActionCancel = "Cancel".localized
        static let alertActionRetry = "Retry".localized
    }
    
    @IBOutlet private weak var creditScoreView: ProgressIndicatorView!
    @IBOutlet private weak var creditScoreTitleLabel: UILabel!
    @IBOutlet private weak var creditScoreLabel: UILabel!
    @IBOutlet private weak var maxCreditScoreLabel: UILabel!
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    
    var viewModel: DashboardViewModel!
    
    private var disposables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        viewModel.fetchCreditScore()
    }
    
    //Binding between view and viewModel
    private func bind() {
        
        title = viewModel.viewTitle
        creditScoreTitleLabel.text = viewModel.credtScoreTitleText
        
        disposables = [
            viewModel.$currentScore.assign(to: \.text!, on: creditScoreLabel),
            viewModel.$maxScore.assign(to: \.text!, on: maxCreditScoreLabel),
            viewModel.$showSpinner
                .sink { [weak self] isLoading in
                    isLoading ? self?.spinner.startAnimating() : self?.spinner.stopAnimating()
                },
            
            viewModel.$progressIndicatorValue
                .dropFirst()
                .sink { [weak self] value in
                    self?.creditScoreView.progressBarPercentage = value
                },
            
            viewModel.$showAlert
                .filter { $0 }
                .sink { [weak self] _ in self?.showErrorAlert() }
        ]
    }
    
    // To show alert for error response
    private func showErrorAlert() {
        let alertController = UIAlertController(
            title: Constants.alertTitle,
            message: Constants.alertBody,
            preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: Constants.alertActionCancel, style: .cancel))
        alertController.addAction(UIAlertAction(
            title: Constants.alertActionRetry,
            style: .default,
            handler: { [weak self] _ in
            self?.viewModel?.fetchCreditScore()
        }))
        
        present(alertController, animated: true)
    }
}


//
//  TransactionsListViewModel.swift
//  BudTechnicalTask
//
//  Created by Kristina Nenkova on 21/09/2018.
//  Copyright © 2018 Kristina Nenkova. All rights reserved.
//

import Foundation

protocol TransactionsListViewModelDelegate: class {
    func willStartFetchingData(viewModel: TransactionsListViewModelProtocol)
    func didFetchData(viewModel: TransactionsListViewModelProtocol)
    func didFailWithError(viewModel: TransactionsListViewModelProtocol, error: Error)
}

protocol TransactionsListViewModelProtocol {
    var delegate: TransactionsListViewModelDelegate? { get set }
    var transactions: [Transaction] { get set }
    func fetchData()
}

final class TransactionsListViewModel: TransactionsListViewModelProtocol {
    var delegate: TransactionsListViewModelDelegate?
    
    var transactions: [Transaction] = []
    let apiManager: TransactionManager
    
    // MARK: - Initialization
    
    init(apiManager: TransactionManager) {
        self.apiManager = apiManager
    }
    
    // MARK: - TransactionsListViewModelProtocol
    
    func fetchData() {
        self.delegate?.willStartFetchingData(viewModel: self)
        
        self.delegate?.didFetchData(viewModel: self)
        
        self.apiManager.readAll() { transactionsResponse, error in
            DispatchQueue.main.async {
                if let error = error  {
                    self.delegate?.didFailWithError(viewModel: self, error: error)
                } else if let transactions = transactionsResponse {
                    self.transactions = transactions
                    self.delegate?.didFetchData(viewModel: self)
                }
            }
        }
    }
}

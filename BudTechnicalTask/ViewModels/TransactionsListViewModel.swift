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
    var numberOfRows: Int { get }
    func fetchData()
    func transactionAtIndex(_ index: Int) -> Transaction
}

final class TransactionsListViewModel: TransactionsListViewModelProtocol {
 
    var delegate: TransactionsListViewModelDelegate?

    let apiManager: TransactionManager
    
    // MARK: - Initialization
    
    init(apiManager: TransactionManager) {
        self.apiManager = apiManager
    }
    
    // MARK: - TransactionsListViewModelProtocol
    
    var transactions: [Transaction] = []
    
    var numberOfRows: Int {
        return self.transactions.count
    }
    
    func fetchData() {
        self.delegate?.willStartFetchingData(viewModel: self)
        
        self.apiManager.readAll() { [weak self] transactionsResponse, error in
            guard let `self` = self else { return }
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
    
    func transactionAtIndex(_ index: Int) -> Transaction {
        return self.transactions[index]
    }
}

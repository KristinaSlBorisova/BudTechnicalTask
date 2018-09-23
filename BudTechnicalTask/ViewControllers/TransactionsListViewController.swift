//
//  TransactionsListViewController.swift
//  BudTechnicalTask
//
//  Created by Kristina Nenkova on 21/09/2018.
//  Copyright © 2018 Kristina Nenkova. All rights reserved.
//

import UIKit

final class ТransactionsListViewController: UIViewController, TransactionsListViewModelDelegate, UITableViewDataSource {
    
    private var viewModel: TransactionsListViewModelProtocol
    
    init(viewModel: TransactionsListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self.navigationItem.title = NSLocalizedString("TransactionContollerNavigationTitle", comment: "")
        
        self.view.addSubview(self.loadingSpinner)
        self.view.addSubview(self.tableView)
        
        self.tableView.register(TransactionTableViewCell.self, forCellReuseIdentifier: "TransactionTableViewCell")
        self.tableView.dataSource = self
        
        self.loadingSpinner.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addConstraints([
            NSLayoutConstraint(item: self.loadingSpinner, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: self.loadingSpinner, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: self.tableView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: self.tableView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: self.tableView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: self.tableView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0),
            ])
        self.viewModel.fetchData()
    }
    
    // MARK: Getters
    
    private let loadingSpinner: UIActivityIndicatorView = {
        let loadingSpinner = UIActivityIndicatorView()
        loadingSpinner.color = UIColor.gray
        loadingSpinner.hidesWhenStopped = true
        return loadingSpinner
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        tableView.tableFooterView = UIView()
        tableView.separatorInset = .zero
        return tableView
    }()
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue Reusable Cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTableViewCell", for: indexPath) as? TransactionTableViewCell else {
            fatalError("Unexpected Index Path")
        }
        
        let transaction = self.viewModel.transactionAtIndex(indexPath.row)
        
        cell.setTitle(transaction.product.title)
        cell.setSubtitle(transaction.description)
        cell.setIconWithString(transaction.product.iconURLString)
        
        return cell
    }
    
    
    // MARK: TransactionsListViewModelDelegate
    
    func willStartFetchingData(viewModel: TransactionsListViewModelProtocol) {
        self.loadingSpinner.startAnimating()
        self.tableView.isHidden = true
    }
    
    func didFetchData(viewModel: TransactionsListViewModelProtocol) {
        self.loadingSpinner.stopAnimating()
        self.tableView.isHidden = false
        self.tableView.reloadData()
    }
    
    func didFailWithError(viewModel: TransactionsListViewModelProtocol, error: Error) {
        self.loadingSpinner.stopAnimating()
        self.tableView.isHidden = true
        
        let alertController = UIAlertController(title: NSLocalizedString("FoundationError", comment: ""),
                                                message: error.localizedDescription,
                                                preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("FoundationCancel", comment: ""), style: .cancel)
        let retryAction = UIAlertAction(title: NSLocalizedString("FoundationRetry", comment: ""), style: .default) { _ in
            self.viewModel.fetchData()
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(retryAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

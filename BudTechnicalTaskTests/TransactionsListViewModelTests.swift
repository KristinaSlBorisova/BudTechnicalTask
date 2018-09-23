//
//  TransactionsListViewModelTests.swift
//  BudTechnicalTaskTests
//
//  Created by Kristina Nenkova on 22/09/2018.
//  Copyright © 2018 Kristina Nenkova. All rights reserved.
//

import XCTest
import Mockingjay
import Nimble

@testable import BudTechnicalTask

class TransactionsListViewModelTests: XCTestCase {
    
    class SpyDelegate: TransactionsListViewModelDelegate {
        
        var willFetchDataCalled = false
        var didFetchDataCalled = false
        var didFailWithErrorCalled = false
        
        func willStartFetchingData(viewModel: TransactionsListViewModelProtocol) {
            self.willFetchDataCalled = true
        }
        
        func didFetchData(viewModel: TransactionsListViewModelProtocol) {
            self.didFetchDataCalled = true
        }
        
        func didFailWithError(viewModel: TransactionsListViewModelProtocol, error: Error) {
            self.didFailWithErrorCalled = true
        }
    }
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testFetchDataSuccess() {
        
        let server = Server(baseURL: URL(string: "https://localhost/v2/5b33bdb43200008f0ad1e256")!)
        let apiManager: TransactionManager = { TransactionsAPIManager(server: server) }()
        let viewModel = TransactionsListViewModel(apiManager: apiManager)
        
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "transactions", withExtension: "json") else {
            fail("Missing file: transactions.json")
            return
        }
        
        guard let json = try? Data(contentsOf: url) else {
            fail("Can't create data")
            return
        }
        
        stub(
            http(.get, uri: "https://localhost/v2/5b33bdb43200008f0ad1e256"),
            jsonData(json)
        )
        
        let spyDelegate = SpyDelegate()
        viewModel.delegate = spyDelegate
        viewModel.fetchData()
        
        expect(spyDelegate.willFetchDataCalled).to(beTrue())
        expect(spyDelegate.didFetchDataCalled).toEventually(beTrue())
        expect(spyDelegate.didFailWithErrorCalled).toEventually(beFalse())
    }
    
    func testFetchDataFail() {
        stub(
            http(.get, uri: "https://localhost/v2/5b33bdb43200008f0ad1e256"),
            http(403)
        )
        let server = Server(baseURL: URL(string: "https://localhost/v2/5b33bdb43200008f0ad1e256")!)
        let apiManager: TransactionManager = { TransactionsAPIManager(server: server) }()
        let viewModel = TransactionsListViewModel(apiManager: apiManager)
        
        let spyDelegate = SpyDelegate()
        viewModel.delegate = spyDelegate
        viewModel.fetchData()
        
        expect(spyDelegate.willFetchDataCalled).to(beTrue())
        expect(spyDelegate.didFailWithErrorCalled).toEventually(beTrue())
        expect(spyDelegate.didFetchDataCalled).to(beFalse())
    }
}

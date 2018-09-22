//
//  TransactionTests.swift
//  BudTechnicalTaskTests
//
//  Created by Kristina Nenkova on 21/09/2018.
//  Copyright © 2018 Kristina Nenkova. All rights reserved.
//

import XCTest
import Nimble

@testable import BudTechnicalTask

class TransactionTestsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testTransaction() {
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "transaction", withExtension: "json") else {
            fail("Missing file: transactions.json")
            return
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fail("Can't create data")
            return
        }
        
        let transaction = try? JSONDecoder().decode(Transaction.self, from: data)
        
        expect(transaction).toNot(beNil())
        expect(transaction?.id).to(equal("13acb877dc4d8030c5dacbde33d3496a2ae3asdc000db4c793bda9c3228baca1a28"))
        expect(transaction?.date).to(equal("2018-03-19"))
        expect(transaction?.description).to(equal("Forbidden planet"))
        expect(transaction?.category).to(equal(.music))
        expect(transaction?.currency).to(equal("GBP"))
        expect(transaction?.amount.value).to(equal(13))
        expect(transaction?.amount.currencyIso).to(equal("GBP"))
        expect(transaction?.product.id).to(equal(4279))
        expect(transaction?.product.title).to(equal("Lloyds Bank"))
        expect(transaction?.product.iconURLString).to(equal("https://storage.googleapis.com/budcraftstorage/uploads/products/lloyds-bank/Llyods_Favicon-1_161201_091641.jpg"))
    }
}

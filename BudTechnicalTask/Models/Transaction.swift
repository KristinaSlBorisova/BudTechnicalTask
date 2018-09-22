//
//  Transaction.swift
//  BudTechnicalTask
//
//  Created by Kristina Nenkova on 21/09/2018.
//  Copyright © 2018 Kristina Nenkova. All rights reserved.
//

import Foundation

struct Transaction: Decodable {
    
    enum Category: Int, Decodable {
        case music = 0
        case bills
        case restaurants = 5
        case food
        case groceries
    }
    
    let id: String
    let date: String
    let description: String
    let category: Category
    let currency: String
    let amount: Amount
    let product: Product
    
    enum CodingKeys : String, CodingKey {
        case id
        case date
        case description
        case category = "category_id"
        case currency
        case amount
        case product
    }
}

struct TransactionsList: Decodable {
    let transactionsList: [Transaction]
    
    enum CodingKeys : String, CodingKey {
        case transactionsList = "data"
    }
}

//
//  TransactionsAPIManager.swift
//  BudTechnicalTask
//
//  Created by Kristina Nenkova on 22/09/2018.
//  Copyright © 2018 Kristina Nenkova. All rights reserved.
//

import Foundation

protocol TransactionManager {
    func readAll(completion: @escaping ([Transaction]?, Error?) -> Void)
}

final class TransactionsAPIManager: TransactionManager {
    
    let server: Server
    
    required init(server: Server) {
        self.server = server
    }
    
    func readAll(completion: @escaping ([Transaction]?, Error?) -> Void) {
        
        let task = URLSession.shared.dataTask(with: self.server.baseURL) { (data, response, error) in
            
            if let error = error {
                completion (nil, error)
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "apiError", code: 0, userInfo: ["userInfo": "Error: No data to decode"])
                completion(nil, error as Error)
                return
            }
            
            guard let transaction = try? JSONDecoder().decode(TransactionsList.self, from: data) else {
                let error = NSError(domain: "apiError", code: 0, userInfo: ["userInfo": "Error: Couldn't decode data into list of transactions"])
                completion(nil, error as Error)
                return
                
            }
            completion(transaction.transactionsList, nil)
        }
        
        task.resume()
    }
}

//
//  Server.swift
//  BudTechnicalTask
//
//  Created by Kristina Nenkova on 22/09/2018.
//  Copyright © 2018 Kristina Nenkova. All rights reserved.
//

import Foundation

final class Server: NSObject {
    
    /**
     The base URL used to fetch data.
     */
    let baseURL: URL
    
    required init(baseURL: URL) {
        self.baseURL = baseURL
    }
}

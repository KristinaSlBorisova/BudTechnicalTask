//
//  Amount.swift
//  BudTechnicalTask
//
//  Created by Kristina Nenkova on 21/09/2018.
//  Copyright © 2018 Kristina Nenkova. All rights reserved.
//

import Foundation

struct Amount: Decodable {
    let value: Float
    let currencyIso: String
    
    enum CodingKeys : String, CodingKey {
        case value
        case currencyIso = "currency_iso"
    }
}

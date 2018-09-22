//
//  Amount.swift
//  BudTechnicalTask
//
//  Created by Kristina Nenkova on 21/09/2018.
//  Copyright © 2018 Kristina Nenkova. All rights reserved.
//

import Foundation

//final class Amount {
//
//    let value: Float
//    let currencyIso: String
//
//    init(value: Float, currencyIso: String) {
//        self.value = value
//        self.currencyIso = currencyIso
//    }
//}
//
//extension Amount: Decodable {
//    static func decode(_ j: Any) throws -> Amount {
//        return try Amount(
//            value: j => "value",
//            currencyIso: j => "currency_iso"
//            )
//    }
//}

struct Amount: Decodable {
    let value: Float
    let currencyIso: String
    
    enum CodingKeys : String, CodingKey {
        case value
        case currencyIso = "currency_iso"
    }
}

//
//  Product.swift
//  BudTechnicalTask
//
//  Created by Kristina Nenkova on 21/09/2018.
//  Copyright © 2018 Kristina Nenkova. All rights reserved.
//

import Foundation

struct Product: Decodable {
    let id: Int
    let title: String
    let iconURLString: String
    
    enum CodingKeys : String, CodingKey {
        case id
        case title
        case iconURLString = "icon"
    }
}

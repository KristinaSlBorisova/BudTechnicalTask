//
//  Product.swift
//  BudTechnicalTask
//
//  Created by Kristina Nenkova on 21/09/2018.
//  Copyright © 2018 Kristina Nenkova. All rights reserved.
//

import Foundation

//final class Product {
//
//    let identifier: String
//    let title: String
//    let iconURLString: String
//
//    init(identifier: String, title: String, iconURLString: String) {
//        self.identifier = identifier
//        self.title = title
//        self.iconURLString = iconURLString
//    }
//}
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

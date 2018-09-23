//
//  Helpers.swift
//  BudTechnicalTask
//
//  Created by Kristina Nenkova on 23/09/2018.
//  Copyright © 2018 Kristina Nenkova. All rights reserved.
//

import Foundation
import UIKit

final class Helpers: NSObject {
    
    class func generateStringForAmount(_ amount: Amount) -> String {
        let formatter = NumberFormatter()
        formatter.currencyCode = amount.currencyIso
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .currencyAccounting
        formatter.locale = Locale.current
        return formatter.string(from: NSNumber(value: amount.value)) ?? ""
    }
    
    class func generateAttributedTitleForTransactionCategory(_ category: Transaction.Category) -> NSMutableAttributedString {
        switch category {
        case .music:
            return NSMutableAttributedString(
                string: NSLocalizedString("MusicCategotyTitle", comment: ""),
                attributes: [
                    NSAttributedStringKey.foregroundColor: UIColor.magenta,
                    ]
            )
        case .bills:
            return NSMutableAttributedString(
                string: NSLocalizedString("BillsCategoryTitle", comment: ""),
                attributes: [
                    NSAttributedStringKey.foregroundColor: UIColor.purple,
                    ]
            )
        case .restaurants:
            return NSMutableAttributedString(
                string: NSLocalizedString("RestaurantsCategoryTitle", comment: ""),
                attributes: [
                    NSAttributedStringKey.foregroundColor: UIColor.cyan,
                    ]
            )
        case .food:
            return NSMutableAttributedString(
                string: NSLocalizedString("FoodCategoryTitle", comment: ""),
                attributes: [
                    NSAttributedStringKey.foregroundColor: UIColor.green,
                    ]
            )
        case .groceries:
            return NSMutableAttributedString(
                string: NSLocalizedString("GroceriesCategoryTitle", comment: ""),
                attributes: [
                    NSAttributedStringKey.foregroundColor: UIColor.blue,
                    ]
            )
            
        }
    }
}

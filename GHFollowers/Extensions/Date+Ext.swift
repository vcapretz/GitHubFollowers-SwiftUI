//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by Vitor Capretz on 18/06/22.
//

import Foundation

extension Date {
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        
        return dateFormatter.string(from: self)
    }
}

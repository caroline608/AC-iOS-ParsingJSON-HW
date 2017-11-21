//
//  Stock.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Keshawn Swanston on 11/20/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class Stock {
    let date: String
    let open: Double
    let close: Double
    var priceWentUp: Bool {
        return close > open
    }
    var dateFormat: (yearMonthformatted: String, monthId: Int, yearMonth: String) {
    var dictMonths = [1: "January", 2: "February", 3: "March",
                      4: "April", 5: "May", 6: "June",
                      7: "July", 8: "August", 9: "September",
                      10: "October", 11: "November", 12: "December"]
    let year = Int(String(self.date.split(separator: "-")[0])) ?? 0
    let monthId = Int(String(self.date.split(separator: "-")[1])) ?? 0
    let month = dictMonths[Int(String(self.date.split(separator: "-")[1]))!] ?? "Not Found"
    let yearMonth = String(self.date.split(separator: "-")[0...1].joined())
    return ("\(month) - \(year)", monthId, yearMonth)
    }
    
    let label: String
    init(date: String, open: Double, close: Double, label: String) {
        self.date = date
        self.close = close
        self.open = open
        self.label = label
    }
    convenience init?(from dictStock: [String: Any]) {
        guard let date = dictStock["date"] as? String else { return nil }
        let open = dictStock["open"] as? Double ?? 0.0
        let close = dictStock["close"] as? Double ?? 0.0
        let label = dictStock["label"] as? String ?? "Not Found"
        self.init(date: date, open: open, close: close, label: label)
    }
    
    static func createStockArr(from data: Data) -> [Stock] {
        var allStocks: [Stock] = []
        do {
            guard let stockArr = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] else { return [] }
            for stockDict in stockArr {
                if let thisStock = Stock(from: stockDict) {
                    allStocks.append(thisStock)
                }
            }
        } catch let error {
            print(error)
        }
        return allStocks
    }
}

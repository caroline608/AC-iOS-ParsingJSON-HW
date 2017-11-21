//
//  StocksTableViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Keshawn Swanston on 11/20/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class StocksTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var stocks:[Stock] = []
    var handlingSection = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadData()
    }
    
    
    func loadData() {
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                self.stocks = Stock.createStockArr(from: data)
            }
        }
        var index = 0
        for stock in self.stocks {
            let yearMonth = stock.dateFormat.yearMonth
            if !handlingSection.contains(yearMonth) {
                handlingSection.append(yearMonth)
                index += 1
            }
        }
    }
    // MARK: - Data Source Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return handlingSection.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let numberOfStocks = stocks.filter{$0.dateFormat.yearMonth == handlingSection[section]}
        let myAverage = String(format: "%.2f", (numberOfStocks.reduce(0){(a, b) in return a + b.open} / Double(numberOfStocks.count)))
        return numberOfStocks.first!.dateFormat.yearMonthformatted + ": Average: $\(myAverage)"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let mySectionRows = stocks.filter{$0.dateFormat.yearMonth == handlingSection[section]}
        return mySectionRows.count
    }

 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let stock = stocks.filter{$0.dateFormat.yearMonth == handlingSection[indexPath.section]}[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "StockCell", for: indexPath)
        cell.textLabel?.text = "\(stock.date)"
        cell.detailTextLabel?.text = "\(stock.open)"
        return cell
    }
    
    // MARK: - Navigation


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? StockDetailViewController {
            let selectedRow = tableView.indexPathForSelectedRow!.row
            let selectedStock = self.stocks[selectedRow]
            destination.stock = selectedStock
        }
    }
    

}










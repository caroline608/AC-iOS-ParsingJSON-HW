//
//  StockDetailViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Keshawn Swanston on 11/20/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class StockDetailViewController: UIViewController {
    
    var stock: Stock!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var closeLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        dateLabel.text = stock.date
        if stock.priceWentUp {
            imageView.image = UIImage(named: "thumbsUp")
            self.view.backgroundColor = .green
        } else {
            imageView.image = UIImage(named: "thumbsDown")
            self.view.backgroundColor = .red
        }
        openLabel.text = String(stock.open)
        closeLabel.text = String(stock.close)
    }

    



}

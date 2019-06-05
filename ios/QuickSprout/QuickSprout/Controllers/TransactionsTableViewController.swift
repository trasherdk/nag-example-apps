//
//  TransactionsTableViewController.swift
//  QuickSprout
//
//  Created by Brian Vestergaard Danielsen on 14/11/2018.
//  Copyright © 2018 Brian Vestergaard Danielsen. All rights reserved.
//

import UIKit

class TransactionsTableViewController: UITableViewController {
    
    var transactions: [QSTransaction]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.transactions?.count {
            return count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transactionTableViewCell", for: indexPath) as! QSTransactionTableViewCell
        if let transaction = transactions?[indexPath.row] {
            cell.populate(transaction: transaction)
        }
        return cell
    }
}

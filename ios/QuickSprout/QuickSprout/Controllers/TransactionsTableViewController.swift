//
//  TransactionsTableViewController.swift
//  QuickSprout
//
//  Created by Brian Vestergaard Danielsen on 14/11/2018.
//  Copyright © 2018 Brian Vestergaard Danielsen. All rights reserved.
//

import UIKit

class TransactionsTableViewController: UITableViewController {
    
    var transactionsResponse: QSGetTransactionsResponse?
    
    @IBOutlet weak var fetchMore: UIButton!
    
    @IBAction func fetchMorePressed(_ sender: Any) {
        debugPrint("fetch more with paging token: " + (transactionsResponse?.pagingToken ?? "-"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.transactionsResponse?.transactions.count {
            return count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transactionTableViewCell", for: indexPath) as! QSTransactionTableViewCell
        
        if let t = transactionsResponse {
            let transaction = t.transactions[indexPath.row]
            cell.populate(transaction: transaction)
        }
        
        // Only enable the fetch more button if a paging token is present
        fetchMore.isEnabled = transactionsResponse?.pagingToken != nil
        
        return cell
    }
}

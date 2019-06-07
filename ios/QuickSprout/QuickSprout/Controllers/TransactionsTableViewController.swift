//
//  TransactionsTableViewController.swift
//  QuickSprout
//
//  Created by Brian Vestergaard Danielsen on 14/11/2018.
//  Copyright © 2018 Brian Vestergaard Danielsen. All rights reserved.
//

import UIKit

class TransactionsTableViewController: UITableViewController {
    
    var latestTransactionsResponse: QSGetTransactionsResponse?
    var transactions: [QSTransaction]?
    var accessToken: String?
    var accountId: String?
    var pagingToken: String? {
        get {
            return latestTransactionsResponse?.pagingToken
        }
    }
    
    @IBOutlet weak var fetchMoreButton: UIButton!
    
    @IBAction func fetchMorePressed(_ sender: Any) {
        if let pagingToken = self.pagingToken {
            QSAPI.transactions(accessToken: accessToken!, accountId: accountId!, pagingToken: pagingToken) { (transactionsResponse) in
                self.latestTransactionsResponse = transactionsResponse
                self.transactions! += transactionsResponse.transactions
                self.tableView.reloadData()
            }
        }
    }
    
    func setResponse(response: QSGetTransactionsResponse) {
        self.latestTransactionsResponse = response
        self.transactions = response.transactions
    }
    
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
        
        if let transactions = self.transactions {
            let transaction = transactions[indexPath.row]
            cell.populate(transaction: transaction)
        }
        
        // Only enable the fetch more button if a paging token is present
        fetchMoreButton.isEnabled = self.pagingToken != nil
        
        return cell
    }
}

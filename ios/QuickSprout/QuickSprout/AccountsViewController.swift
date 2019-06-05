//
//  AccountsViewController.swift
//  QuickSprout
//
//  Created by Brian Vestergaard Danielsen on 30/10/2018.
//  Copyright © 2018 Brian Vestergaard Danielsen. All rights reserved.
//

import UIKit

class AccountsViewController: UITableViewController {
    
    var accounts: [QSAccount]? = []
    var accessToken: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.accounts?.count {
            return count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "accountTableViewCell", for: indexPath) as! QSAccountTableViewCell
        if let account = accounts?[indexPath.row] {
            cell.populate(account: account)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let account = accounts?[indexPath.row] {
            QSAPI.transactions(accessToken: accessToken!, accountId: account.id!) { (transactionsResponse) in
                let viewController = UIStoryboard.instantiateTransactionsViewController()
                viewController.transactions = transactionsResponse.transactions
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }
}


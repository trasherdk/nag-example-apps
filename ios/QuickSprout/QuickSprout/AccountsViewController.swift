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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
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
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}


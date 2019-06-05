//
//  QSTransactionTableViewCell.swift
//  QuickSprout
//
//  Created by Brian Vestergaard Danielsen on 30/10/2018.
//  Copyright © 2018 Brian Vestergaard Danielsen. All rights reserved.
//

import UIKit

class QSTransactionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var currency: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var type: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func populate(transaction: QSTransaction) -> Void {
        name.text = transaction.text
        date.text = transaction.date
        currency.text = transaction.currency
        if let _amount = transaction.amount {
            amount.text = String(format:"%.2f", _amount.value)            
        }
        type.text = transaction.type
    }
}

//
//  QSAccountTableViewCell.swift
//  QuickSprout
//
//  Created by Brian Vestergaard Danielsen on 30/10/2018.
//  Copyright © 2018 Brian Vestergaard Danielsen. All rights reserved.
//

import UIKit

class QSAccountTableViewCell: UITableViewCell {

  @IBOutlet weak var name: UILabel!
  @IBOutlet weak var providerId: UILabel!
  @IBOutlet weak var iban: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
  func populate(account: QSAccount) -> Void {
    name.text = account.name
    providerId.text = account.providerId
    iban.text = account.iban
  }
}

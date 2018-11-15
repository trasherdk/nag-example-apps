//
//  QSTransaction.swift
//  QuickSprout
//
//  Created by Brian Vestergaard Danielsen on 14/11/2018.
//  Copyright © 2018 Brian Vestergaard Danielsen. All rights reserved.
//

import Foundation

struct QSTransaction {
    
    var id: String?
    var date: String?
    var creationDate: String?
    var text: String?
    var originalText: String?
    var amount: Double?
    var type: String?
    var currency: String?
    var state: String?
    
    init(id: String, date: String, creationDate: String, text: String, type: String, amount: Double, currency: String, state: String) {
        self.id = id
        self.date = date
        self.creationDate = creationDate
        self.text = text
        self.amount = amount
        self.currency = currency
        self.state = state
    }
}

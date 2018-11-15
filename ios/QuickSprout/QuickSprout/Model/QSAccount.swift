//
//  QSAccount.swift
//  QuickSprout
//
//  Created by Brian Vestergaard Danielsen on 30/10/2018.
//  Copyright © 2018 Brian Vestergaard Danielsen. All rights reserved.
//

import Foundation

struct QSAccount {
    
    var id: String?
    var providerId: String?
    var name: String?
    var iban: String?
    var currency: String?
    var bookedBalance: Double?
    
    init(id: String, providerId: String, name: String, iban: String, currency: String, bookedBalance: Double) {
        self.id = id
        self.providerId = providerId
        self.name = name
        self.iban = iban
        self.currency = currency
        self.bookedBalance = bookedBalance
    }
}

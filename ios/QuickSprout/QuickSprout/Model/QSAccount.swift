//
//  QSAccount.swift
//  QuickSprout
//
//  Created by Brian Vestergaard Danielsen on 30/10/2018.
//  Copyright © 2018 Brian Vestergaard Danielsen. All rights reserved.
//

import Foundation

struct QSAccount {

  var providerId: String?
  var name: String?
  var iban: String?
  var currency: String?
  var bookedBalance: String?
  
  init(providerId: String, name: String, iban: String, currency: String, bookedBalance: String) {
    self.providerId = providerId
    self.name = name
    self.iban = iban
    self.currency = currency
    self.bookedBalance = bookedBalance
  }
}
